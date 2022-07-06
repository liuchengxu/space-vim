scriptencoding utf-8

let g:spacevim.info = g:spacevim.base. '/core/autoload/spacevim/info.vim'
let g:spacevim.layers_base = '/layers'
let g:spacevim.private_base = '/private'
let g:spacevim.state_base = fnamemodify(exists('*stdpath') ? stdpath('state') :
  \ (g:spacevim.os.windows ? '~/AppData/Local/vim-data' :
  \   (exists('$XDG_STATE_HOME') ? $XDG_STATE_HOME : '~/.local/state').'/vim'), ':p')
let g:spacevim.nvim = has('nvim') && exists('*jobwait') && !g:spacevim.os.windows
let g:spacevim.vim8 = exists('*job_start')
let g:spacevim.timer = exists('*timer_start')
let g:spacevim.gui = has('gui_running')
let g:spacevim.tmux = !empty($TMUX)

let g:spacevim.loaded = ['spacevim'] " Enable spacevim layer by default
let g:spacevim.excluded = []
let g:spacevim.plugins = []
let g:spacevim.enable_dein_recache = v:false

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
  call s:define_command()
  call s:cache()
  call s:check_dot_spacevim()
  call s:check_dein_vim()
endfunction

function! s:check_dein_vim() abort
  let s:dein_path = g:spacevim_plug_home.'/repos/github.com/Shougo/dein.vim'
  if empty(glob(s:dein_path.'/.git')) | call spacevim#vim#plug#download(s:dein_path) | endif
  let &runtimepath .= ','.fnamemodify(s:dein_path, ':p:h')
endfunction

function! s:define_command() abort
  " MP means MyPlugin
  command! -nargs=+ -bar MP          call s:my_plugin(<args>)
  command! -nargs=+ -bar Layer       call s:layer(<args>)
  command! -nargs=0 -bar SpaceInfo   call spacevim#debugging#Info()
  command! -nargs=0 -bar LayerCache  call spacevim#cache#init()
  command! -nargs=0 -bar LayerStatus call spacevim#layer#status()
  command! -nargs=+ -bar Plug        call spacevim#vim#plug#Plug(<args>)
endfunction

function! s:check_dot_spacevim() abort
  if filereadable(expand(s:dot_spacevim))
    call s:check_dot_spacevim_preset_variables()
    call s:Source(s:dot_spacevim)
    call extend(g:spacevim.loaded, get(g:, 'spacevim_layers', []))
    call s:check_dot_spacevim_postset_variables()
    if(getftype(g:spacevim.state_base) !~# '\(dir\|link\)')
      call mkdir(g:spacevim.state_base, 'p')
    endif
    call spacevim#util#CheckFileTimestamp(
      \ s:dot_spacevim,
      \ g:spacevim.state_base.'/.dot_spacevim_last_changed',
      \ {-> execute('let g:spacevim.enable_dein_recache = v:true')})
  else
    call spacevim#util#err('.spacevim does not exist! Exiting...')
  endif
endfunction

function! s:check_dot_spacevim_preset_variables() abort
  let g:dein#types#git#clone_depth = 1
  let g:dein#enable_hook_function_cache = v:true
  let g:dein#install_process_timeout = 6000
endfunction

function! s:check_dot_spacevim_postset_variables() abort
  let g:mapleader = get(g:, 'spacevim_leader', "\<Space>")
  let g:maplocalleader = get(g:, 'spacevim_localleader', ',')
  let g:spacevim_plug_home = get(g:, 'spacevim_plug_home',
    \ g:spacevim.nvim ? '~/.local/share/nvim/plugged' : '~/.vim/plugged')
  let g:spacevim_enable_plug_cache = get(g:, 'spacevim_enable_plug_cache', 1)
  let g:spacevim_enable_plug_merge = get(g:, 'spacevim_enable_plug_merge', 1)
  let g:spacevim_enable_temp_build = get(g:, 'spacevim_enable_temp_build', 0)
  let g:spacevim_lsp_engine = get(g:, 'spacevim_lsp_engine', 'lcn')
  let g:spacevim.speed_up_via_timer = get(g:, 'spacevim_speed_up_via_timer', g:spacevim.timer)
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
  endif
endfunction

function! s:Source(file) abort
  try
    execute 'source ' . fnameescape(a:file)
  catch
    call spacevim#util#err(v:exception)
    call spacevim#cache#init()
  endtry
endfunction

function! s:path(path) abort
  return substitute(a:path, '/', '\', 'g')
endfunction

function! spacevim#end() abort
  " Backward compatibility
  if exists('*Layers') | call Layers() | endif

  call s:validate_manifest()

  call s:register_plugin()
  " Make vim-better-default settings can be overrided
  silent! runtime! plugin/default.vim

  call s:config()
  if exists('*UserConfig') | call UserConfig() | endif

  call spacevim#util#CheckFileTimestamp(
    \ g:spacevim.base.'/core/doc/spacevim.txt',
    \ g:spacevim.base.'/core/doc/.spacevim_last_helptags_run',
    \ {-> execute('helptags '.g:spacevim.base.'/core/doc')})

  call s:check_missing_plugins()
  silent doautocmd <nomodeline> User SpacevimAfterUserConfig
endfunction

function! s:validate_manifest() abort
  if !empty(filter(copy(g:spacevim.loaded), {_,v -> !has_key(g:spacevim.manifest, v)}))
    call spacevim#util#info('.spacevim specifies layer(s) not in info.vim: trying to rebuild info.vim')
    call spacevim#cache#init()
    let bad_layers = filter(copy(g:spacevim.loaded), {_,v -> !has_key(g:spacevim.manifest, v)})
    if !empty(bad_layers)
      call spacevim#util#info('.spacevim specifies the following invalid layers: '.string(bad_layers))
      call filter(g:spacevim.loaded, {_,v -> has_key(g:spacevim.manifest, v)})
    endif
  endif
endfunction

" Initialize dein system
function! s:register_plugin() abort
  if g:spacevim_enable_plug_merge == 0
    let g:dein#default_options = { 'merged': v:false }
  endif

  call spacevim#vim#plug#dein_cache_setup()

  if !g:spacevim_enable_plug_cache || g:spacevim.enable_dein_recache || dein#load_state(g:spacevim_plug_home)
    call dein#begin(g:spacevim_plug_home)
    call dein#add(s:dein_path)
    call s:packages()
    function! s:register(val) abort
      if has_key(s:plug_options, a:val)
        call dein#add(a:val, s:plug_options[a:val])
      else
        call dein#add(a:val)
      endif
    endfunction
    call extend(g:spacevim.excluded, get(g:, 'spacevim_excluded', []))
    call dein#disable(g:spacevim.excluded)
    call map(copy(g:spacevim.plugins), {_,v -> s:register(v)})
    if exists('*UserInit') | call UserInit() | endif
    if g:spacevim_enable_plug_cache
      call spacevim#vim#plug#dein_cache_clear()
    endif
    if g:spacevim.enable_dein_recache && g:spacevim_enable_plug_merge
      call dein#recache_runtimepath()
    endif
    call dein#end()
    if g:spacevim_enable_plug_cache
      call dein#save_state()
    endif
  endif
  filetype plugin indent on
  syntax enable
  delcommand Plug
  delcommand MP
endfunction

function! s:packages() abort
  " Load Layer packages
  call map(copy(g:spacevim.loaded), {_,v -> s:Source(g:spacevim.manifest[v].dir.'/packages.vim')})

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
