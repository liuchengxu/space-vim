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
let s:private_config = g:spacevim.base.'/private/config.vim'
let s:private_packages = g:spacevim.base.'/private/packages.vim'
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
  command! -nargs=0 -bar SpaceInfo   call spacevim#debugging#Info()
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
      call extend(g:spacevim.excluded, s:to_a(a:arg['exclude']))
    else
      throw 'Invalid option (expected: exclude)'
    endif
  else
    throw 'Invalid argument type (expected: dictionary)'
  endif
endfunction

" This is an only one possible extra argument: plug option, dict
function! s:my_plugin(plugin, ...) abort
  if index(g:spacevim.plugins, a:plugin) < 0
    call add(g:spacevim.plugins, a:plugin)
  endif
  if a:0 == 1
    let s:plug_options[a:plugin] = a:1
    if has_key(a:1, 'on_event')
      let l:group = 'load/'.a:plugin
      let l:name = split(a:plugin, '/')[1]
      let l:events = join(s:to_a(a:1.on_event), ',')
      let l:load = printf("call plug#load('%s')", l:name)
      execute "augroup" l:group
      autocmd!
      execute 'autocmd' l:events '*' l:load '|' 'autocmd!' l:group
      execute 'augroup END'
    endif
  endif
endfunction

function! s:Source(file) abort
  try
    execute 'source ' . fnameescape(a:file)
  catch
    echom v:exception
    call spacevim#cache#init()
  endtry
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

  try
    execute 'helptags' g:spacevim.base . '/core/doc'
  catch
    echom v:exception
  endtry

  call s:check_missing_plugins()
  silent doautocmd <nomodeline> User SpacevimAfterUserConfig
endfunction

" Initialize vim-plug system
function! s:register_plugin() abort
  " https://github.com/junegunn/vim-plug/issues/559
  call plug#begin(get(g:, 'spacevim_plug_home',
        \ g:spacevim.nvim ? '~/.local/share/nvim/plugged' : '~/.vim/plugged/'))
  call s:packages()
  " Register non-excluded plugins
  function! s:filter_and_register(val) abort
    if index(g:spacevim.excluded, a:val) < 0
      if has_key(s:plug_options, a:val)
        call plug#(a:val, s:plug_options[a:val])
      else
        call plug#(a:val)
      endif
    endif
  endfunction
  call extend(g:spacevim.excluded, get(g:, 'spacevim_excluded', []))
  call map(copy(g:spacevim.plugins), 's:filter_and_register(v:val)')
  if exists('*UserInit') | call UserInit() | endif
  call plug#end()
endfunction

function! s:packages() abort
  let g:spacevim.speed_up_via_timer = get(g:, 'spacevim_speed_up_via_timer', g:spacevim.timer)
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
    call map(copy(g:spacevim.private), 's:Source(g:spacevim.base ."/private/".v:val."/packages.vim")')
  endif

  " Load private packages
  if filereadable(expand(s:private_packages)) | call s:Source(s:private_packages) | endif
endfunction

function! s:config() abort
  " Load Layer config
  cal map(copy(g:spacevim.loaded), 's:Source(g:spacevim.manifest[v:val].dir . "/config.vim")')

  " Try private Layer config
  if exists('g:spacevim.private')
    call map(copy(g:spacevim.private), 's:Source(g:spacevim.base ."/private/".v:val."/config.vim")')
  endif

  " Load private config
  if filereadable(expand(s:private_config)) | call s:Source(s:private_config) | endif
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

" Return true if any layer in layers is loaded.
function! spacevim#load_any(...) abort
  for layer in a:000
    if index(g:spacevim.loaded, layer) >= 0
      return 1
    endif
  endfor
  return 0
endfunction
