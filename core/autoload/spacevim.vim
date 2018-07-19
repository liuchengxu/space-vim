scriptencoding utf-8

let g:spacevim.info = g:spacevim.base. '/core/autoload/spacevim/info.vim'
let g:spacevim.layers_base = '/layers'
let g:spacevim.private_base = '/private'
let g:spacevim.nvim = has('nvim') && exists('*jobwait') && !g:spacevim.os.windows
let g:spacevim.vim8 = exists('*job_start')
let g:spacevim.timer = exists('*timer_start')
let g:spacevim.gui = has('gui_running')
let g:spacevim.tmux = !empty($TMUX)

let g:spacevim.loaded = ['spacevim'] " Enable spacevim layer by default
let g:spacevim.excluded = []
let g:spacevim.plugins = []

let s:plug_options = {}
let s:dot_spacevim = $HOME.'/.spacevim'
let s:TYPE = {
\ 'string':  type(''),
\ 'list':    type([]),
\ 'dict':    type({}),
\ 'funcref': type(function('call'))
\ }

function! spacevim#bootstrap() abort
  call spacevim#begin()
  call spacevim#end()
endfunction

function! spacevim#begin() abort
  " Download vim-plug if unavailable
  if !g:spacevim.os.windows
    call s:check_vim_plug()
  endif
  call s:define_command()
  call s:cache()
  call s:check_dot_spacevim()
endfunction

function! s:check_vim_plug() abort
  let l:plug_path = g:spacevim.nvim ? '~/.local/share/nvim/site/autoload/plug.vim' : '~/.vim/autoload/plug.vim'
  if empty(glob(l:plug_path)) | call spacevim#vim#plug#download(l:plug_path) | endif
endfunction

function! s:define_command() abort
  " MP means MyPlugin
  command! -nargs=+ -bar MP          call s:my_plugin(<args>)
  command! -nargs=+ -bar Layer       call s:layer(<args>)
  command! -nargs=0 -bar LayerCache  call spacevim#cache#init()
  command! -nargs=0 -bar LayerStatus call spacevim#layer#status()
endfunction

function! s:check_dot_spacevim() abort
  if filereadable(expand(s:dot_spacevim))
    call s:Source(s:dot_spacevim)
    call extend(g:spacevim.loaded, get(g:, 'spacevim_layers', []))
    let g:mapleader = get(g:, 'spacevim_leader', "\<Space>")
    let g:maplocalleader = get(g:, 'spacevim_localleader', ',')
  else
    call spacevim#util#err('.spacevim does not exist! Exiting...')
    finish
  endif
endfunction

function! s:cache() abort
  let l:info = g:spacevim.info
  if filereadable(l:info)
    execute 'source ' . (g:spacevim.os.windows ? s:path(l:info) : l:info)
  else
    call spacevim#cache#init()
  endif
endfunction

function! s:layer(name, ...)
  if index(g:spacevim.loaded, a:name) == -1
    call add(g:spacevim.loaded, a:name)
  endif
  if a:0 > 1
    return spacevim#util#err('Invalid number of arguments (1..2)')
  elseif a:0 == 1
    call s:parse_options(a:1)
  endif
endfunction

function! s:to_a(v) abort
  return type(a:v) == s:TYPE.list ? a:v : [a:v]
endfunction

function! s:parse_options(arg)
  let l:type = type(a:arg)
  if l:type == s:TYPE.dict
    if has_key(a:arg, 'exclude')
      for l:excl in s:to_a(a:arg['exclude'])
        call add(g:spacevim.excluded, l:excl)
      endfor
    else
      throw 'Invalid option (expected: exclude)'
    endif
  else
    throw 'Invalid argument type (expected: dictionary)'
  endif
endfunction

" This is an only one possible extra argument: plug option
function! s:my_plugin(plugin, ...) abort
  if index(g:spacevim.plugins, a:plugin) < 0
    call add(g:spacevim.plugins, a:plugin)
  endif
  if a:0 == 1
    let s:plug_options[a:plugin] = a:1
  endif
endfunction

function! s:Source(file, ...) abort
  " If the extra argument exists, try-catch is not neccessary
  if a:0 == 1
    if filereadable(expand(a:file))
      execute 'source ' . fnameescape(a:file)
    endif
  else
    try
      execute 'source ' . fnameescape(a:file)
    catch
      call spacevim#cache#init()
    endtry
  endif
endfunction

function! s:path(path) abort
  return substitute(a:path, '/', '\', 'g')
endfunction

function! spacevim#end() abort
  " Backward compatibility
  if exists('*Layers') | call Layers() | endif

  call s:register_plugin()
  " Make vim-better-default settings can be overrided
  silent! runtime! plugin/default.vim

  call s:config()
  if exists('*UserConfig') | call UserConfig() | endif
  call s:check_missing_plugins()
endfunction

" Initialize vim-plug system
function! s:register_plugin() abort
  " https://github.com/junegunn/vim-plug/issues/559
  let l:plug_home = g:spacevim.nvim ? '~/.local/share/nvim/plugged' : '~/.vim/plugged/'
  let g:spacevim_plug_home = get(g:, 'spacevim_plug_home', l:plug_home)

  call plug#begin(g:spacevim_plug_home)
  call s:packages()
  " Register non-excluded plugins
  function! s:filter_and_register(val) abort
    if index(g:spacevim.excluded, a:val) < 0
      call plug#(a:val, get(s:plug_options, a:val, ""))
    endif
  endfunction
  call map(g:spacevim.plugins, 's:filter_and_register(v:val)')
  if exists('*UserInit') | call UserInit() | endif
  call plug#end()
endfunction

function! s:packages() abort
  " Load Layer packages
  for l:layer in g:spacevim.loaded
    try
      let l:layer_packages = g:spacevim.manifest[l:layer].dir . '/packages.vim'
    catch
      call spacevim#cache#init()
    endtry
    call s:Source(l:layer_packages)
  endfor

  " Try private Layer packages
  if exists('g:spacevim.private')
    for l:private_layer in g:spacevim.private
      let l:private_layer_packages = g:spacevim.base . '/private/' . l:private_layer . '/packages.vim'
      call s:Source(l:private_layer_packages, 1)
    endfor
  endif

  " Load private packages
  call s:Source(g:spacevim.base . '/private/packages.vim', 1)
endfunction

function! s:config() abort
  " Load Layer config
  cal map(g:spacevim.loaded, 's:Source(g:spacevim.manifest[v:val].dir . "/config.vim")')

  " Try private Layer config
  if exists('g:spacevim.private')
    for l:private_layer in g:spacevim.private
      let l:private_layer_config = g:spacevim.base . '/private/' . l:private_layer . '/config.vim'
      call s:Source(l:private_layer_config, 1)
    endfor
  endif

  " Load private config
  call s:Source(g:spacevim.base . '/private/config.vim')
  silent doautocmd User SpacevimAfterUserConfig
endfunction

function! s:check_missing_plugins() abort
  if g:spacevim.timer
      call timer_start(1500, 'spacevim#vim#plug#check')
  else
    augroup checkPlug
      autocmd!
      autocmd VimEnter * call spacevim#vim#plug#check()
    augroup END
  endif
endfunction

" Util for config.vim and packages.vim
function! spacevim#load(layer) abort
  return index(g:spacevim.loaded, a:layer) > -1 ? 1 : 0
endfunction
