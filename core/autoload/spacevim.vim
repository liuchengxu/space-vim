scriptencoding utf-8

let g:spacevim_layers_dir = '/layers'
let g:spacevim_private_layers_dir = '/private'
let g:spacevim_nvim = has('nvim') && exists('*jobwait') && !g:WINDOWS
let g:spacevim_vim8 = has('patch-8.0.0039') && exists('*job_start')
let g:spacevim_gui_running = has('gui_running')
let g:spacevim_tmux = !empty($TMUX)

let g:layers_loaded = []
let g:spacevim_excluded = []
let g:spacevim_plugins = []
let g:plug_options = {}

let s:dot_spacevim = $HOME.'/.spacevim'
let s:py_exe = has('python') ? 'python' : 'python3'
let s:TYPE = {
\   'string':  type(''),
\   'list':    type([]),
\   'dict':    type({}),
\   'funcref': type(function('call'))
\ }

function! s:err(msg)
    echohl ErrorMsg
    echom '[space-vim] '.a:msg
    echohl None
endfunction

function! s:warn(cmd, msg)
    echohl WarningMsg
    echom '[space-vim] '.a:msg
    echohl None
endfunction

function! s:check_vim_plug(plug_path)
    if empty(glob(a:plug_path))
        echo '==> Downloading vim-plug ......'
        execute '!curl -fLo ' . a:plug_path . ' --create-dirs ' .
                    \   'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    endif
endfunction

function! spacevim#begin()

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

endfunction

function! s:define_command()
    " MP means MyPlugin
    command! -nargs=+ -bar MP call s:my_plugins(<args>)

    command! -nargs=+ -bar Layer call s:layer(<args>)

    command! -nargs=0 -bar LayerStatus call layer#status()
    command! -nargs=0 -bar LayerUpdate call layer#update(s:py_exe)
endfunction

function! s:layer(name, ...)
    if index(g:layers_loaded, a:name) == -1
        call add(g:layers_loaded, a:name)
    endif
    if a:0 > 1
        return s:err('Invalid number of arguments (1..2)')
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

function! s:my_plugins(...)
    if a:0 == 0
        return s:err('Argument missing: plugin name required.')
    elseif a:0 == 1
        call add(g:spacevim_plugins, a:1)
    elseif a:0 == 2
        call add(g:spacevim_plugins, a:1)
        let g:plug_options[a:1] = a:2
    else
        return s:err('Too many arguments for MP command.')
    endif
endfunction

silent function! s:Source(file) abort
    if filereadable(expand(a:file))
        execute 'source ' . fnameescape(a:file)
    else
        echom '[space-vim] ' . a:file . ' does not exist, which may cause unexpected errors. Try running `:LayerUpdate` to get rid of this error.'
    endif
endfunction

function! s:path(path)
    return substitute(a:path, '/', '\', 'g')
endfunction

function! s:layers_info() abort
    let g:spacevim_info_path = g:spacevim_dir. '/core/autoload/info.vim'
    let g:spacevim_info_path = g:WINDOWS ? s:path(g:spacevim_info_path) : g:spacevim_info_path
    if filereadable(g:spacevim_info_path)
        execute 'source ' . g:spacevim_info_path
    else
        call layer#update(s:py_exe)
    endif
endfunction

function! s:check_dot_spacevim()
    if filereadable(expand(s:dot_spacevim))
        call s:Source(s:dot_spacevim)
        return 1
    else
        echom '.spacevim does not exist!!!'
        return 0
    endif
endfunction

function! spacevim#end()

    if s:check_dot_spacevim()

        if !exists('g:spacevim_plug_home')
            " https://github.com/junegunn/vim-plug/issues/559
            let g:spacevim_plug_home = g:spacevim_nvim ? '~/.local/share/nvim/plugged' : '~/.vim/plugged/'
        endif

        call plug#begin(g:spacevim_plug_home)

        if exists('*Layers')
            call Layers()
        endif

        call s:layers_info()

        call s:load_packages()

        call s:filter_plugins()
        call s:invoke_plug()

        if exists('*UserInit')
            call UserInit()
        endif

        call plug#end()

        let g:mapleader = get(g:, 'spacevim_leader', "\<Space>")
        let g:maplocalleader = get(g:, 'spacevim_localleader', ',')

        " Make vim-better-default settings can be overrided
        silent! runtime! plugin/default.vim

        call s:load_config()

        if exists('*UserConfig')
            call UserConfig()
        endif

        call s:post_user_config()
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

function! s:load_packages()
    " Load Layer packages
    for l:layer in g:layers_loaded
        let l:layer_packages = g:layer_path[l:layer] . '/packages.vim'
        call s:Source(l:layer_packages)
    endfor

    " Try private Layer packages
    for l:private_layer in g:private_layers
        let l:private_layer_packages = g:spacevim_dir . '/private/' . l:private_layer . '/packages.vim'
        if filereadable(expand(l:private_layer_packages))
            execute 'source ' . fnameescape(l:private_layer_packages)
        endif
    endfor

    " Load private packages
    let l:private_packages = g:spacevim_dir . '/private/packages.vim'
    if filereadable(expand(l:private_packages))
        execute 'source ' . fnameescape(l:private_packages)
    endif
endfunction

function! s:load_config()
    " Load Layer config
    for l:layer in g:layers_loaded
        let l:layer_config = g:layer_path[l:layer] . '/config.vim'
        call s:Source(l:layer_config)
    endfor

    " Try private Layer config
    for l:private_layer in g:private_layers
        let l:private_layer_config = g:spacevim_dir . '/private/' . l:private_layer . '/config.vim'
        if filereadable(expand(l:private_layer_config))
            execute 'source ' . fnameescape(l:private_layer_config)
        endif
    endfor

    " Load private config
    let l:private_config = g:spacevim_dir . '/private/config.vim'
    if filereadable(expand(l:private_config))
        execute 'source ' . fnameescape(l:private_config)
    endif
endfunction

function! s:post_user_config()

    autocmd BufRead,BufNewFile *.spacevim setlocal filetype=vim

    " airline
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

    " https://github.com/junegunn/vim-plug/wiki/extra#automatically-install-missing-plugins-on-startup
    augroup PLUG_CHECK
        autocmd!
        autocmd VimEnter *
          \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
          \|   echom '[space-vim] Some layers need to install the missing plugins first!'
          \|   PlugInstall --sync | q
          \| endif
    augroup END

endfunction
