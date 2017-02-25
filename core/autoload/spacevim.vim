let g:spacevim_nvim = has('nvim') && exists('*jobwait') && !g:WINDOWS
let g:spacevim_vim8 = has('patch-8.0.0039') && exists('*job_start')
let g:spacevim_gui_running = has('gui_running')
let g:spacevim_tmux = !empty($TMUX)

let g:layers_loaded = []

let s:dot_spacevim = $HOME.'/.spacevim'
let s:spacevim_layers_dir = '/layers'
let s:spacevim_private_layers_dir = '/private'

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

    let l:vim_home = $HOME.'/.vim/'

    if g:spacevim_nvim
        " https://github.com/junegunn/vim-plug/issues/559
        let g:my_plug_home = '~/.local/shared/nvim/plugged'
    else
        let g:my_plug_home = l:vim_home.'plugged/'
    endif

    call s:define_command()

endfunction

function! s:define_command()
    " MP means MyPlugin
    command! -nargs=+ -bar MP call s:my_plugins(<args>)

    command! -nargs=+ -bar Layer call s:layers(<args>)
    command! -nargs=+ -bar Exclude call s:exclude(<args>)

    command! -nargs=0 -bar LayerStatus call layer#status()
    command! -nargs=0 -bar LayerUpdate call spacevim#info()
endfunction

function! s:layers(...)
    if a:0 == 0
        return s:err('Argument missing: Layer name required.')
    elseif a:0 == 1
        call add(g:layers_loaded, a:1)
    else
        call s:err('Options not supported now. Sorry for that.')
    endif
endfunction

let g:spacevim_plugins = []
let g:plug_options = {}

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

let g:spacevim_exclude = []

function! s:exclude(...)
    if a:0 == 0
        return s:err('Argument missing: element name(s) required.')
    elseif a:0 == 1
        call add(g:spacevim_exclude, a:1)
    else
        return s:err('Too many arguments for Exlcude command!')
    endif
endfunction

silent function! s:Source(file) abort
    if filereadable(expand(a:file))
        execute 'source ' . fnameescape(a:file)
    else
        echom '[space-vim] ' . a:file . ' does not exist, which may cause unexpected errors.'
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

" get the whole available layers number s:layers_sum, number
" get the topics s:topics, list
" get the pair topic to layers s:topic2layers, dict
function! spacevim#info() abort

let py_exe = has('python') ? 'python' : 'python3'

execute py_exe "<< EOF"
import os
import vim

spacevim_dir = vim.eval('g:spacevim_dir')
topic_base = spacevim_dir + vim.eval('s:spacevim_layers_dir')
private_base = spacevim_dir + vim.eval('s:spacevim_private_layers_dir')

topics = [f for f in os.listdir(topic_base) if os.path.isdir(os.path.join(topic_base,f))]
private_layers = [f for f in os.listdir(private_base) if os.path.isdir(os.path.join(private_base,f))]

layer_path = {}
topic2layers = {}
layers_sum = len(private_layers)

for t in topics:
    topic_path = topic_base + '/' + t
    layers = [f for f in os.listdir(topic_path) if os.path.isdir(os.path.join(topic_path,f))]
    layers_sum += len(layers)
    topic2layers[t] = layers
    for l in layers:
        layer_path[l] = topic_path + '/' + l

vim.command("let g:layers_sum = %d" % layers_sum)
vim.command("let g:topics = %s" % topics)
vim.command("let g:topic2layers = %s" % topic2layers)
vim.command("let g:private_layers = %s" % private_layers)
vim.command("let g:layer_path = %s" % layer_path)

f = open(vim.eval('g:spacevim_info_path'), 'w')
f.write("let g:layers_sum = %d\n" % layers_sum)
f.write("let g:topics = %s\n" % topics)
f.write("let g:topic2layers = %s\n" % topic2layers)
f.write("let g:private_layers = %s\n" % private_layers)
f.write("let g:layer_path = %s\n" % layer_path)
f.close()

EOF

endfunction

function! s:layers_info()
    let g:spacevim_info_path = g:spacevim_dir. '/core/autoload/info.vim'
    if filereadable(g:spacevim_info_path)
        execute 'source' . g:spacevim_info_path
    else
        call spacevim#info()
    endif
endfunction

function! spacevim#end()

    if s:check_dot_spacevim()

        call plug#begin(g:my_plug_home)

        call Layers()

        call s:layers_info()

        call s:load_packages()

        call s:filter_plugins()
        call s:invoke_plug()

        call UserInit()

        call plug#end()

        if exists('g:spacevim_leader')
            let g:mapleader=g:spacevim_leader
        else
            let g:mapleader = "\<Space>"
        endif

        if exists('g:spacevim_localleader')
            let g:maplocalleader=g:spacevim_localleader
        else
            let g:maplocalleader = ','
        endif

        " Make vim-better-default settings can be overrided
        silent! runtime! plugin/default.vim

        call s:load_config()

        call UserConfig()

        call s:post_user_config()
    endif

endfunction

function! s:filter_plugins()

let py_exe = has('python') ? 'python' : 'python3'

execute py_exe "<< EOF"
import vim
exclude = vim.eval('g:spacevim_exclude')
my_plugins = vim.eval('g:spacevim_plugins')
plugins = list(set(my_plugins)^set(exclude))
vim.command('let g:spacevim_plugs = %s' % plugins)
EOF
endfunction

function! s:invoke_plug()
    for plug in g:spacevim_plugs
        call plug#(plug, get(g:plug_options, plug, ''))
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

function! s:statusline_hi()
    " default bg for statusline is 236 in space-vim-dark
    hi paste       cterm=bold ctermfg=149 ctermbg=239 gui=bold guifg=#99CC66 guibg=#3a3a3a
    hi ale_error   cterm=None ctermfg=197 ctermbg=237 gui=None guifg=#CC0033 guibg=#3a3a3a
    hi ale_warning cterm=None ctermfg=214 ctermbg=237 gui=None guifg=#FFFF66 guibg=#3a3a3a

    hi User1 cterm=bold ctermfg=232 ctermbg=179 gui=Bold guifg=#333300 guibg=#FFBF48
    hi User2 cterm=None ctermfg=214 ctermbg=243 gui=None guifg=#FFBB7D guibg=#666666
    hi User3 cterm=None ctermfg=251 ctermbg=241 gui=None guifg=#c6c6c6 guibg=#585858
    hi User4 cterm=Bold ctermfg=177 ctermbg=239 gui=Bold guifg=#d75fd7 guibg=#4e4e4e
    hi User5 cterm=None ctermfg=208 ctermbg=238 gui=None guifg=#ff8700 guibg=#3a3a3a
    hi User6 cterm=Bold ctermfg=178 ctermbg=237 gui=Bold guifg=#FFE920 guibg=#444444
    hi User7 cterm=None ctermfg=250 ctermbg=238 gui=None guifg=#bcbcbc guibg=#444444
    hi User8 cterm=None ctermfg=249 ctermbg=239 gui=None guifg=#b2b2b2 guibg=#4e4e4e
    hi User9 cterm=None ctermfg=249 ctermbg=241 gui=None guifg=#b2b2b2 guibg=#606060
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

    " User-defined highlightings shoule be put after colorscheme command.
    call s:statusline_hi()

    " https://github.com/junegunn/vim-plug/wiki/extra#automatically-install-missing-plugins-on-startup
    autocmd VimEnter *
      \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \|   echom '[space-vim] Some layers need to install the missing plugins first!'
      \|   PlugInstall --sync | q
      \| endif

endfunction
