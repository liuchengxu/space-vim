
let s:spacevim_layers_dir = '/layers'
let s:dot_spacevim = $HOME.'/.spacevim'

let s:spacevim_tab = get(s:, 'spacevim_tab', -1)
let s:spacevim_buf = get(s:, 'spacevim_buf', -1)

let g:layers_loaded = []

autocmd BufRead,BufNewFile *.spacevim set filetype=vim

function! LayerLoaded(layer)
    if index(g:layers_loaded, a:layer) > -1
        return 1
    else
        return 0
    endif
endfunction

" get the whole available layers number s:layers_sum, number
" get the topics s:topics, list
" get the pair topic to layers s:topic2layers, dict
function! s:collect_topics()

let py_exe = has('python') ? 'python' : 'python3'

execute py_exe "<< EOF"
import os
import vim
topic_base = vim.eval('g:spacevim_base_dir') + vim.eval('s:spacevim_layers_dir')
topics = [f for f in os.listdir(topic_base) if os.path.isdir(os.path.join(topic_base,f))]
topic2layers = {}
layers_sum = 0
for t in topics:
    topic_path = topic_base + '/' + t
    layers = [f for f in os.listdir(topic_path) if os.path.isdir(os.path.join(topic_path,f))]
    layers_sum = layers_sum + len(layers)
    topic2layers[t] = layers
vim.command("let s:layers_sum = %d" % layers_sum)
vim.command("let s:topics = %s" % topics)
vim.command("let s:topic2layers = %s" % topic2layers)
EOF

endfunction

call s:collect_topics()

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

function! LayersBegin()

    " Download vim-plug if unavailable
    if empty(glob('~/.vim/autoload/plug.vim'))
        echo '==> Downloading vim-plug ......'
        execute '!curl -fLo ~/.vim/autoload/plug.vim
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    endif

    let s:vim_home = $HOME.'/.vim/'

    if !exists('g:my_plug_home')
        let g:my_plug_home = s:vim_home.'plugged/'
    endif

    call plug#begin(g:my_plug_home)

    call s:define_command()

endfunction

function! s:define_command()
    command! -nargs=+ -bar Layer call s:add_layer(<f-args>)
    command! -nargs=0 -bar LayerInstall call s:layer_install()
    command! -nargs=0 -bar LayerClean call s:layer_clean()
    command! -nargs=0 -bar LayerUpdate call s:layer_update()
    command! -nargs=0 -bar LayerStatus call s:layer_status()
endfunction

function! s:add_layer(...)
    if a:0 == 0
        return s:err('Argument missing: layer name(s) required.')
    elseif a:0 == 1
        call add(g:layers_loaded, eval(a:1))
    else
        call s:err('Options not supported now. Sorry for that.')
    endif
endfunction

function! s:layer_install()
    execute 'PlugInstall'
endfunction

function! s:layer_update()
    execute 'PlugUpdate'
endfunction

function! s:layer_clean()
    execute 'PlugClean'
endfunction

function! s:new_window()
    execute get(g:, 'spacevim_window', 'vertical topleft new')
endfunction

function! s:spacevim_window_exists()
    let l:buflist = tabpagebuflist(s:spacevim_tab)
    return !empty(l:buflist) && index(l:buflist, s:spacevim_buf) >= 0
endfunction

function! s:assign_name()
    " Assign buffer name
    let l:prefix = '[Layers]'
    let l:name   = l:prefix
    let l:idx    = 2
    while bufexists(l:name)
        let l:name = printf('%s (%s)', l:prefix, l:idx)
        let l:idx = l:idx + 1
    endwhile
    silent! execute 'f' fnameescape(l:name)
endfunction

function! s:layer_status()
    call s:new_window()

    let b:spacevim_preview = -1
    let s:spacevim_tab = tabpagenr()
    let s:spacevim_buf = winbufnr(0)
    call s:assign_name()

    let [l:cnt, l:total] = [0, len(g:layers_loaded)]

    call append(0, ['Enabled layers: ' . '(' . len(g:layers_loaded) . '/' . s:layers_sum . ')'])
    call setline(2, '[' . repeat('=', len(g:layers_loaded)) . ']')
    let l:inx = 3
    for l:layer in g:layers_loaded
        call setline(l:inx, '+ ' . l:layer)
        let l:inx = l:inx + 1
    endfor
    setlocal buftype=nofile bufhidden=wipe nobuflisted nolist noswapfile nowrap cursorline nomodifiable nospell
    setf spacevim
    if exists('g:syntax_on')
        call s:syntax()
    endif
endfunction

function! s:syntax()
    syntax clear
    syntax region Layer1 start=/\%1l/ end=/\%2l/ contains=LayerNumber
    syntax region Layer2 start=/\%2l/ end=/\%3l/ contains=LayerBracket,LayerX
    syn match LayerNumber /[0-9]\+[0-9.]*/ contained
    syn match LayerBracket /[[\]]/ contained
    syn match LayerX /x/ contained
    syn match LayerDash /^-/
    syn match LayerPlus /^+/
    syn match LayerStar /^*/
    syn match LayerMessage /\(^- \)\@<=.*/
    syn match LayerName /\(^- \)\@<=[^ ]*:/
    syn match LayerSha /\%(: \)\@<=[0-9a-f]\{4,}$/
    syn match LayerTag /(tag: [^)]\+)/
    syn match LayerInstall /\(^+ \)\@<=[^:]*/
    syn match LayerUpdate /\(^* \)\@<=[^:]*/
    syn match LayerCommit /^  \X*[0-9a-f]\{7} .*/ contains=LayerRelDate,LayerEdge,LayerTag
    syn match LayerEdge /^  \X\+$/
    syn match LayerEdge /^  \X*/ contained nextgroup=LayerSha
    syn match LayerSha /[0-9a-f]\{7}/ contained
    syn match LayerRelDate /([^)]*)$/ contained
    syn match LayerNotLoaded /(not loaded)$/
    syn match LayerError /^x.*/
    syn region LayerDeleted start=/^\~ .*/ end=/^\ze\S/
    syn match LayerH2 /^.*:\n-\+$/
    syn keyword Function LayerInstall LayerStatus LayerUpdate LayerClean
    hi def link Layer1       Title
    hi def link Layer2       Repeat
    hi def link LayerH2      Type
    hi def link LayerX       Exception
    hi def link LayerBracket Structure
    hi def link LayerNumber  Number

    hi def link LayerDash    Special
    hi def link LayerPlus    Constant
    hi def link LayerStar    Boolean

    hi def link LayerMessage Function
    hi def link LayerName    Label
    hi def link LayerInstall Function
    hi def link LayerUpdate  Type

    hi def link LayerError   Error
    hi def link LayerDeleted Ignore
    hi def link LayerRelDate Comment
    hi def link LayerEdge    PreProc
    hi def link LayerSha     Identifier
    hi def link LayerTag     Constant

    hi def link LayerNotLoaded Comment
endfunction

function! s:check_user_config()
    if filereadable(expand(s:dot_spacevim))
        call Source(s:dot_spacevim)
        let s:dot_spacevim_exists = 1
    else
        let s:dot_spacevim_exists = 0
    endif
endfunction

function! LayersEnd()

    call s:check_user_config()

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

    if s:dot_spacevim_exists
        call UserInit()
    endif

    call s:load_layer_packages()
    call s:load_private_packages()

    call plug#end()

    call s:load_layer_config()
    call s:load_private_config()

    if s:dot_spacevim_exists
        call UserConfig()
    endif

endfunction

" Return the layer's base dir
function! s:cur_layer_base_dir(layer)

    let l:layers_base = g:spacevim_base_dir . s:spacevim_layers_dir
    for [key, val] in items(s:topic2layers)
        if index(val, a:layer) > -1
            return l:layers_base . '/' . key . '/'
        endif
    endfor
    return s:err('Layer * ' . a:layer . ' * is invalid, please check it.')
endfunction

function! s:load_layer_packages()
    for l:layer in g:layers_loaded
        let l:layer_packages = s:cur_layer_base_dir(l:layer) . l:layer . '/packages.vim'
        call Source(l:layer_packages)
    endfor
endfunction

function! s:load_private_packages()
    let l:private_packages = g:spacevim_base_dir . '/private/packages.vim'
    if filereadable(expand(l:private_packages))
        execute 'source ' . fnameescape(l:private_packages)
    endif
endfunction

function! s:load_layer_config()
    for l:layer in g:layers_loaded
        let l:layer_config = s:cur_layer_base_dir(l:layer) . l:layer . '/config.vim'
        call Source(l:layer_config)
    endfor
endfunction

function! s:load_private_config()
    let l:private_config = g:spacevim_base_dir . '/private/config.vim'
    if filereadable(expand(l:private_config))
        execute 'source ' . fnameescape(l:private_config)
    endif
endfunction
