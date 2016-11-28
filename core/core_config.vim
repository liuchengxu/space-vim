let s:TYPE = {
            \   'string':  type(''),
            \   'list':    type([]),
            \   'dict':    type({}),
            \   'funcref': type(function('call'))
            \ }

let g:LAYERS = [
            \   'better-defaults',
            \   'markdown',
            \   'python',
            \   'c-c++',
            \   'syntax-checking',
            \   'ycmd',
            \]


let g:layers_loaded = []

function! s:load_layers_package()
    for layer in g:layers_loaded
        let l:layer_packages = g:spacevim_base_dir . g:spacevim_layers_dir . '/' . layer . '/packages.vim'
        " echo 'start sourcing: ' . l:layer_packages
        if filereadable(expand(l:layer_packages))
            execute "source " . fnameescape(l:layer_packages)
        else
            echom l:layer_packages . ' does not exist, please check it.'
            return
        endif
    endfor
endfunction

function! s:load_layers_config()
    for layer in g:layers_loaded
        let l:layer_config = g:spacevim_base_dir . g:spacevim_layers_dir . '/' . layer . '/config.vim'
        " echo 'start sourcing: ' . l:layer_config
        if filereadable(expand(l:layer_config))
            execute "source " . fnameescape(l:layer_config)
        else
            echom l:layer_packages . ' doesnot exist, please check it.'
        endif
    endfor
endfunction

function! s:load_private_config()
    let s:config_file = g:spacevim_base_dir . '/private/after_vimrc.vim'
    if filereadable(expand(s:config_file))
        execute "source " . fnameescape(s:config_file)
    endif
endfunction
"

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

    call s:load_layers_package()
    call plug#end()
    call s:load_layers_config()
    call s:load_private_config()

endfunction

function! s:trim(str)
    return substitute(a:str, '[\/]\+$', '', '')
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
