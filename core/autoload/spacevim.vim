scriptencoding utf-8

let g:spacevim_layers_dir = '/layers'
let g:spacevim_private_layers_dir = '/private'
let g:spacevim_nvim = has('nvim') && exists('*jobwait') && !g:WINDOWS
let g:spacevim_vim8 = has('patch-8.0.0039') && exists('*job_start')
let g:spacevim_gui = has('gui_running')
let g:spacevim_tmux = !empty($TMUX)

let g:layers_loaded = []
let g:spacevim_excluded = []
let g:spacevim_plugins = []
let g:plug_options = {}

let s:dot_spacevim = $HOME.'/.spacevim'
let s:py_exe = has('python') ? 'python' : 'python3'
let s:TYPE = {
\ 'string':  type(''),
\ 'list':    type([]),
\ 'dict':    type({}),
\ 'funcref': type(function('call'))
\ }

function! spacevim#begin() abort

  let l:vim_plug_path = '~/.vim/autoload/plug.vim'
  let l:nvim_plug_path = '~/.local/share/nvim/site/autoload/plug.vim'

  " Download vim-plug if unavailable
  if !g:WINDOWS
    if g:spacevim_nvim
      call s:check_vim_plug(l:nvim_plug_path)
    else
      call s:check_vim_plug(l:vim_plug_path)
    endif
  endif

  call s:define_command()

  call s:layers_info()

  if s:check_dot_spacevim()
    try
      call Layers()
    catch
      call spacevim#util#err('Layers() does not exist in .spacevim!')
    endtry
  endif

endfunction

function! s:check_vim_plug(plug_path)
  if empty(glob(a:plug_path))
    echo '==> Downloading vim-plug ......'
    execute '!curl -fLo ' . a:plug_path . ' --create-dirs ' .
          \   'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  endif
endfunction

function! s:define_command()
  " MP means MyPlugin
  command! -nargs=+ -bar MP          call s:my_plugin(<args>)
  command! -nargs=+ -bar Layer       call s:layer(<args>)
  command! -nargs=0 -bar LayerStatus call spacevim#layer#status()
  command! -nargs=0 -bar LayerUpdate call spacevim#layer#update(s:py_exe)
endfunction

function! s:check_dot_spacevim()
  if filereadable(expand(s:dot_spacevim))
    call s:Source(s:dot_spacevim)
    return 1
  else
    call spacevim#util#err('.spacevim does not exist!!!')
    return 0
  endif
endfunction

function! s:layers_info() abort
  let g:spacevim_info_path = g:spacevim_dir. '/core/autoload/spacevim/info.vim'
  let g:spacevim_info_path = g:WINDOWS ? s:path(g:spacevim_info_path) : g:spacevim_info_path
  if filereadable(g:spacevim_info_path)
    execute 'source ' . g:spacevim_info_path
  else
    call spacevim#layer#update(s:py_exe)
  endif
endfunction

function! s:layer(name, ...)
  if index(g:layers_loaded, a:name) == -1
    call add(g:layers_loaded, a:name)
  endif
  if a:0 > 1
    return spacevim#util#err('Invalid number of arguments (1..2)')
  elseif a:0 == 1
    call s:parse_options(a:1)
  endif
endfunction

function! s:to_a(v)
  return type(a:v) == s:TYPE.list ? a:v : [a:v]
endfunction

function! s:parse_options(arg)
  let l:type = type(a:arg)
  if l:type == s:TYPE.dict
    if has_key(a:arg, 'exclude')
      for l:excl in s:to_a(a:arg['exclude'])
        call add(g:spacevim_excluded, l:excl)
      endfor
    else
      throw 'Invalid option (expected: exclude)'
    endif
  else
    throw 'Invalid argument type (expected: dictionary)'
  endif
endfunction

function! s:my_plugin(plugin, ...)
  call add(g:spacevim_plugins, a:plugin)
  if a:0 == 1
    let g:plug_options[a:plugin] = a:1
  endif
endfunction

function! s:Source(file)
  try
    execute 'source ' . fnameescape(a:file)
  catch
    call spacevim#layer#update(s:py_exe)
  endtry
endfunction

function! s:path(path)
  return substitute(a:path, '/', '\', 'g')
endfunction

function! spacevim#end()
  call s:register_plugin()

  let g:mapleader = get(g:, 'spacevim_leader', "\<Space>")
  let g:maplocalleader = get(g:, 'spacevim_localleader', ',')

  " Make vim-better-default settings can be overrided
  silent! runtime! plugin/default.vim

  call s:config()
  try
    call UserConfig()
  catch
    call spacevim#util#err('Error occurs in UserConfig()!')
  endtry
  call s:post_user_config()
endfunction

function! s:register_plugin()
  if !exists('g:spacevim_plug_home')
    " https://github.com/junegunn/vim-plug/issues/559
    let g:spacevim_plug_home = g:spacevim_nvim ? '~/.local/share/nvim/plugged' : '~/.vim/plugged/'
  endif

  call plug#begin(g:spacevim_plug_home)

  call s:packages()

  call s:filter_plugins()
  call s:invoke_plug()

  try
    call UserInit()
  catch
      call spacevim#util#err('Error occurs in UserInit()!')
  endtry

  call plug#end()
endfunction

function! s:packages()
  " Load Layer packages
  for l:layer in g:layers_loaded
    try
      let l:layer_packages = g:layer_path[l:layer] . '/packages.vim'
    catch
      call spacevim#layer#update(s:py_exe)
    endtry
    call s:Source(l:layer_packages)
  endfor

  " Try private Layer packages
  if exists('g:private_layers')
    for l:private_layer in g:private_layers
      let l:private_layer_packages = g:spacevim_dir . '/private/' . l:private_layer . '/packages.vim'
      if filereadable(expand(l:private_layer_packages))
        execute 'source ' . fnameescape(l:private_layer_packages)
      endif
    endfor
  endif

  " Load private packages
  let l:private_packages = g:spacevim_dir . '/private/packages.vim'
  if filereadable(expand(l:private_packages))
    execute 'source ' . fnameescape(l:private_packages)
  endif
endfunction

function! s:filter_plugins()
  for l:excl in g:spacevim_excluded
    let l:idx = index(g:spacevim_plugins, l:excl)
    if l:idx > -1
      call remove(g:spacevim_plugins, l:idx)
    endif
  endfor
endfunction

function! s:invoke_plug()
  for l:plugin in g:spacevim_plugins
    call plug#(l:plugin, get(g:plug_options, l:plugin, ''))
  endfor
endfunction

function! s:config()
  " Load Layer config
  for l:layer in g:layers_loaded
    try
      let l:layer_config = g:layer_path[l:layer] . '/config.vim'
    catch
      call spacevim#layer#update(s:py_exe)
    endtry
    call s:Source(l:layer_config)
  endfor

  " Try private Layer config
  if exists('g:private_layers')
    for l:private_layer in g:private_layers
      let l:private_layer_config = g:spacevim_dir . '/private/' . l:private_layer . '/config.vim'
      if filereadable(expand(l:private_layer_config))
        execute 'source ' . fnameescape(l:private_layer_config)
      endif
    endfor
  endif

  " Load private config
  let l:private_config = g:spacevim_dir . '/private/config.vim'
  if filereadable(expand(l:private_config))
    execute 'source ' . fnameescape(l:private_config)
  endif
endfunction

function! s:post_user_config()

  autocmd BufRead,BufNewFile *.spacevim setlocal filetype=vim
  autocmd FileType vim setlocal tabstop=2 shiftwidth=2 softtabstop=2

  " airline {
  if !exists('g:airline_powerline_fonts')
    let g:airline_left_sep=''
    let g:airline_right_sep=''

    if !g:WINDOWS
      let g:airline_symbols = {}
      let g:airline_symbols.linenr = '␊'
      let g:airline_symbols.linenr = '␤'
      let g:airline_symbols.linenr = '¶'
      let g:airline_symbols.branch = '⎇'
      let g:airline_symbols.paste = 'Þ'
      let g:airline_symbols.whitespace = 'Ξ'
    endif
  endif
  " }

  " vim_current_word {
    hi CurrentWord      gui=underline cterm=underline
    hi CurrentWordTwins gui=underline cterm=underline
  " }

  " https://github.com/junegunn/vim-plug/wiki/extra#automatically-install-missing-plugins-on-startup
  augroup checkPlug
    autocmd!
    autocmd VimEnter *
      \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \|   echom '[space-vim] Some layers need to install the missing plugins first!'
      \|   PlugInstall --sync | q
      \| endif
  augroup END

endfunction
