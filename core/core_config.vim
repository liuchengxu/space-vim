let s:spacevim_layers_dir = "/layers"

let s:TYPE = {
            \   'string':  type(''),
            \   'list':    type([]),
            \   'dict':    type({}),
            \   'funcref': type(function('call'))
            \ }

let g:LANG = [
            \   'c-c++',
            \   'python',
            \   'markdown',
            \]

let g:FUN = [
            \   'emoji',
            \]

let g:VIM = [
            \   'better-defaults',
            \]

let g:TOOLS = [
            \   'ycmd',
            \]

let g:THEMES = [
            \   'colors',
            \]

let g:CHECKERS = [
            \   'syntax-checking',
            \]

let g:layers_loaded = []

" Return the layer's base dir
function! s:layer_base_dir(layer)
    if index(g:VIM, a:layer) > -1
        return g:spacevim_base_dir . s:spacevim_layers_dir . '/+vim/' . a:layer
    elseif index(g:LANG, a:layer) > -1
        return g:spacevim_base_dir . s:spacevim_layers_dir . '/+lang/' . a:layer
    elseif index(g:FUN, a:layer) > -1
        return g:spacevim_base_dir . s:spacevim_layers_dir . '/+fun/' . a:layer
    elseif index(g:TOOLS, a:layer) > -1
        return g:spacevim_base_dir . s:spacevim_layers_dir . '/+tools/' . a:layer
    elseif index(g:THEMES, a:layer) > -1
        return g:spacevim_base_dir . s:spacevim_layers_dir . '/+themes/' . a:layer
    elseif index(g:CHECKERS, a:layer) > -1
        return g:spacevim_base_dir . s:spacevim_layers_dir . '/+checkers/' . a:layer
    else
        return g:spacevim_base_dir . s:spacevim_layers_dir . '/' . a:layer
    endif
endfunction

function! s:load_layer_packages()
    for layer in g:layers_loaded
        let l:layer_packages = s:layer_base_dir(layer) . '/packages.vim'
        call Source(l:layer_packages)
    endfor
endfunction

function! s:load_layer_config()
    for layer in g:layers_loaded
        let l:layer_config = s:layer_base_dir(layer) . '/config.vim'
        call Source(l:layer_config)
    endfor
endfunction

function! s:load_private_config()
    else
        return g:spacevim_base_dir . s:spacevim_layers_dir . '/' . a:layer
    endif
endfunction

function! s:load_layer_packages()
    for layer in g:layers_loaded
        let l:layer_packages = s:layer_base_dir(layer) . '/packages.vim'
        call Source(l:layer_packages)
    endfor
endfunction

function! s:load_layer_config()
    for layer in g:layers_loaded
        let l:layer_config = s:layer_base_dir(layer) . '/config.vim'
        call Source(l:layer_config)
    endfor
endfunction

function! s:load_private_config()
    let l:private_config = g:spacevim_base_dir . '/private/after_vimrc.vim'
    call Source(l:private_config)
endfunction

function! s:to_a(v)
    return type(a:v) == s:TYPE.list ? a:v : [a:v]
endfunction

function! s:to_s(v)
    return type(a:v) == s:TYPE.string ? a:v : join(a:v, "\n") . "\n"
endfunction

function! s:define_command()
    command! -nargs=+ -bar Layer call s:add_layer(<f-args>)
endfunction

function! LayersBegin()

    " Load vim-plug
    if empty(glob("~/.vim/autoload/plug.vim"))
        execute '!curl -fLo ~/.vim/autoload/plug.vim
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    endif

    call plug#begin()
    call s:define_command()

endfunction

function! LayersEnd()

    call s:load_layer_packages()
    call plug#end()
    call s:load_layer_config()
    call s:load_private_config()

endfunction

function! s:err(msg)
    echohl ErrorMsg
    echom '[space-vim] '.a:msg
    echohl None
endfunction

function! s:warn(cmd, msg)
    echohl WarningMsg
    execute a:cmd 'a:msg'
    echohl None
endfunction

function! s:add_layer(...)
    if a:0 == 0
        return s:err('Argument missing: layer name(s) required.')
    elseif a:0 == 1
        call add(g:layers_loaded, eval(a:1))
    else
        echom 'Options not supported now.'
    endif
endfunction
