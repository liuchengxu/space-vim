scriptencoding utf-8

let g:spacevim_layers_dir = '/layers'
let g:spacevim_private_layers_dir = '/private'
let g:spacevim_nvim = has('nvim') && exists('*jobwait') && !g:WINDOWS
let g:spacevim_vim8 = exists('*job_start')
let g:spacevim_timer = exists('*timer_start')
let g:spacevim_gui = has('gui_running')
let g:spacevim_tmux = !empty($TMUX)

let g:spacevim = {}
let g:layers_loaded = []
let g:spacevim_excluded = []
let g:spacevim_plugins = []
let g:plug_options = {}

let s:dot_spacevim = $HOME.'/.spacevim'
let s:TYPE = {
\ 'string':  type(''),
\ 'list':    type([]),
\ 'dict':    type({}),
\ 'funcref': type(function('call'))
\ }

function! spacevim#begin() abort
  " Download vim-plug if unavailable
  if !g:WINDOWS
    call s:check_vim_plug()
  endif
  call s:define_command()
  call s:cache()
  call s:check_dot_spacevim()
endfunction

function! s:check_vim_plug()
  let l:plug_path = g:spacevim_nvim ? '~/.local/share/nvim/site/autoload/plug.vim' : '~/.vim/autoload/plug.vim'
  if empty(glob(l:plug_path))
    call spacevim#vim#plug#download(l:plug_path)
  endif
endfunction

function! s:define_command()
  " MP means MyPlugin
  command! -nargs=+ -bar MP          call s:my_plugin(<args>)
  command! -nargs=+ -bar Layer       call s:layer(<args>)
  command! -nargs=0 -bar LayerCache  call spacevim#cache#init()
  command! -nargs=0 -bar LayerStatus call spacevim#layer#status()
endfunction

function! s:check_dot_spacevim()
  if filereadable(expand(s:dot_spacevim))
    call s:Source(s:dot_spacevim)
    if exists('g:spacevim_layers')
      let g:layers_loaded = g:layers_loaded + g:spacevim_layers
    endif
    let g:mapleader = get(g:, 'spacevim_leader', "\<Space>")
    let g:maplocalleader = get(g:, 'spacevim_localleader', ',')
  else
    call spacevim#util#err('.spacevim does not exist! Exiting...')
    finish
  endif
endfunction

function! s:cache() abort
  let g:spacevim_info_path = g:spacevim_dir. '/core/autoload/spacevim/info.vim'
  let g:spacevim_info_path = g:WINDOWS ? s:path(g:spacevim_info_path) : g:spacevim_info_path
  if filereadable(g:spacevim_info_path)
    execute 'source ' . g:spacevim_info_path
  else
    call spacevim#cache#init()
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
  if index(g:spacevim_plugins, a:plugin) < 0
    call add(g:spacevim_plugins, a:plugin)
  endif
  if a:0 == 1
    let g:plug_options[a:plugin] = a:1
  endif
endfunction

function! s:Source(file)
  try
    execute 'source ' . fnameescape(a:file)
  catch
    call spacevim#cache#init()
  endtry
endfunction

function! s:path(path)
  return substitute(a:path, '/', '\', 'g')
endfunction

function! spacevim#end() abort

  " Backward compatibility
  if exists('*Layers')
    call Layers()
  endif

  call s:register_plugin()

  " Make vim-better-default settings can be overrided
  silent! runtime! plugin/default.vim

  call s:config()
  if exists('*UserConfig')
    call UserConfig()
  endif
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

  if exists('*UserInit')
    call UserInit()
  endif

  call plug#end()
endfunction

function! s:packages()
  " Load Layer packages
  for l:layer in g:layers_loaded
    try
      let l:layer_packages = g:spacevim[l:layer].dir . '/packages.vim'
    catch
      call spacevim#cache#init()
    endtry
    call s:Source(l:layer_packages)
  endfor

  " Try private Layer packages
  if exists('g:private')
    for l:private_layer in g:private
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
  call filter(g:spacevim_plugins, 'index(g:spacevim_excluded, v:val) < 0')
endfunction

function! s:invoke_plug()
  for l:plugin in g:spacevim_plugins
    call plug#(l:plugin, get(g:plug_options, l:plugin, ''))
  endfor
endfunction

function! s:config()
  " Load Layer config
  for l:layer in g:layers_loaded
    call s:Source(g:spacevim[l:layer].dir . '/config.vim')
  endfor

  " Try private Layer config
  if exists('g:private')
    for l:private_layer in g:private
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
  " airline {
  if !exists('g:airline_powerline_fonts')
    let g:airline_left_sep=''
    let g:airline_right_sep=''
    if !g:WINDOWS
      let g:airline_synbols = g:spacevim#plug#airline#symbols
    endif
  endif
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

" Util for config.vim and packages.vim
function! spacevim#load(layer) abort
    return index(g:layers_loaded, a:layer) > -1 ? 1 : 0
endfunction
