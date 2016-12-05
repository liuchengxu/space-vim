let s:spacevim_layers_dir = '/layers'

let s:spacevim_tab = get(s:, 'spacevim_tab', -1)
let s:spacevim_buf = get(s:, 'spacevim_buf', -1)

autocmd BufRead,BufNewFile *.spacevim set filetype=vim

let s:TYPE = {
            \   'string':  type(''),
            \   'list':    type([]),
            \   'dict':    type({}),
            \   'funcref': type(function('call'))
            \ }

let g:LANG = [
            \   'c-c++',
            \   'html',
            \   'python',
            \   'markdown',
            \   'graphviz',
            \]

let g:FUN = [
            \   'emoji',
            \   'goyo',
            \]

let g:VIM = [
            \   'better-defaults',
            \   'programming',
            \   'text-align',
            \]

let g:TOOLS = [
            \   'fzf',
            \   'ycmd',
            \]

let g:THEMES = [
            \   'colors',
            \   'airline',
            \]

let g:CHECKERS = [
            \   'syntax-checking',
            \]

let g:COMPLETION = [
            \   'unite',
            \]

let g:OTHERS = [
            \]

let g:VERSION_CONTROL = [
            \   'git',
            \   'github',
            \]

let g:LAYERS = [g:LANG, g:FUN, g:VIM, g:TOOLS, g:THEMES, g:CHECKERS, g:COMPLETION, g:VERSION_CONTROL, g:OTHERS]

let g:layers_loaded = []

" calculate the number of whole available layers
function! s:cal_layers_num()
    let l:num = 0
    for l:topic in g:LAYERS
        let l:num = l:num + len(l:topic)
    endfor
    return l:num
endfunction

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

function! s:to_a(v)
    return type(a:v) == s:TYPE.list ? a:v : [a:v]
endfunction

function! s:to_s(v)
    return type(a:v) == s:TYPE.string ? a:v : join(a:v, "\n") . "\n"
endfunction

function! LayersBegin()

    " Download vim-plug if unavailable
    if empty(glob('~/.vim/autoload/plug.vim'))
        echo '==> Downloading vim-plug ......'
        execute '!curl -fLo ~/.vim/autoload/plug.vim
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    endif

    let s:plugged_home = '~/.vim/plugged'
    " Important
    call plug#begin(s:plugged_home)

    call s:define_command()

endfunction

function! s:define_command()
    command! -nargs=+ -bar Layer call s:add_layer(<f-args>)
    command! -nargs=0 -bar LayerStatus call s:layer_status()
endfunction

function! s:add_layer(...)
    if a:0 == 0
        return s:err('Argument missing: layer name(s) required.')
    elseif a:0 == 1
        call add(g:layers_loaded, eval(a:1))
    else
        call s:err('Options not supported now.')
    endif
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

    call append(0, ['Enabled layers: ' . '(' . len(g:layers_loaded) . '/' . s:cal_layers_num() . ')'])
    call setline(2, '[' . repeat('=', len(g:layers_loaded)) . ']')
    let l:inx = 3
    for l:layer in g:layers_loaded
        call setline(l:inx, '+ ' . l:layer)
        let l:inx = l:inx + 1
    endfor
    setlocal buftype=nofile bufhidden=wipe nobuflisted nolist noswapfile nowrap cursorline nomodifiable
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

function! s:load_private_packages()
    let l:private_packages = g:spacevim_base_dir . '/private/packages.vim'
    if filereadable(expand(l:private_packages))
        execute 'source ' . fnameescape(l:private_packages)
    endif
endfunction

function! s:check_user_config()
    let l:private_spacevim = '~/.spacevim'
    if filereadable(expand(l:private_spacevim))
        call Source(l:private_spacevim)
        let s:private_spacevim_exists = 1
    else
        let s:private_spacevim_exists = 0
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

    if s:private_spacevim_exists
        call UserInit()
    endif

    call s:load_private_packages()

    call s:load_layer_packages()

    call plug#end()

    call s:load_layer_config()

    call s:load_private_config()

    if s:private_spacevim_exists
        call UserConfig()
    endif

endfunction

" Return the layer's base dir
function! s:cur_layer_base_dir(layer)

    let l:layers_base = g:spacevim_base_dir . s:spacevim_layers_dir
    if index(g:VIM, a:layer) > -1
        return l:layers_base . '/+vim/'

    elseif index(g:LANG, a:layer) > -1
        return l:layers_base . '/+lang/'

    elseif index(g:FUN, a:layer) > -1
        return l:layers_base . '/+fun/'

    elseif index(g:TOOLS, a:layer) > -1
        return l:layers_base . '/+tools/'

    elseif index(g:THEMES, a:layer) > -1
        return l:layers_base . '/+themes/'

    elseif index(g:COMPLETION, a:layer) > -1
        return l:layers_base . '/+completion/'

    elseif index(g:CHECKERS, a:layer) > -1
        return l:layers_base . '/+checkers/'

    elseif index(g:VERSION_CONTROL, a:layer) > -1
        return l:layers_base . '/+version-control/'

    elseif index(g:OTHERS, a:layer) > -1
        return l:layers_base . '/'

    else
        return s:err('*' . a:layer . '* is invalid, no such layer, please check it.')

    endif
endfunction

function! s:load_layer_packages()
    for l:layer in g:layers_loaded
        let l:layer_packages = s:cur_layer_base_dir(l:layer) . l:layer . '/packages.vim'
        call Source(l:layer_packages)
    endfor
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


