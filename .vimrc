" Environment {

    " Identify platform {
    silent function! OSX()
        return has('macunix')
    endfunction
    silent function! LINUX()
        return has('unix') && !has('macunix') && !has('win32unix')
    endfunction
    silent function! WINDOWS()
        return (has('win32') || has('win64'))
    endfunction
    " }

" }

let g:spacevim_base_dir = "~/.space-vim/"

" Setup tools {

    " Load the plugins for layers {
    function! LoadLayersPackage(relative_path)
        let s:config_file = g:spacevim_base_dir . a:relative_path
        if filereadable(expand(s:config_file))
            execute "source " . fnameescape(s:config_file)
        else
            echom 'No layers loaded.'
            finish
        endif
    endfunction
    " }

    " Load configuration file for layers {
    function! LoadLayersConfig(layer_base_dir, relative_path)
        for [key, val] in items(g:default_layers)
            let s:config_file = g:spacevim_base_dir . a:layer_base_dir . key . '/' . a:relative_path
            if filereadable(expand(s:config_file))
                execute "source " . fnameescape(s:config_file)
            else
                echom "config.vim for layer " . key . " is not available, please check it."
            endif
        endfor
    endfunction
    " }

    " Load local config if available {
    function! LoadPrivateConfig(relative_path)
        let s:config_file = g:spacevim_base_dir . a:relative_path
        if filereadable(expand(s:config_file))
            execute "source " . fnameescape(s:config_file)
        endif
    endfunction
    " }

" }

call LoadPrivateConfig("private/before_vimrc.vim")

if !exists('g:default_layers')
    let g:default_layers={
                \ 'fzf' : 't',
                \ 'ycmd' : 't',
                \ 'unite' : 't',
                \ 'markdown' : 't',
                \ 'programming' : 't',
                \ 'better-defaults' : 't',
                \ 'syntax-checking' : 'ale',
                \ 'text-align' : 'vim-easy-align',
                \}
endif

if exists('g:spacevim_leader')
    let mapleader=g:spacevim_leader
else
    let mapleader = "\<Space>"
endif

if exists('g:spacevim_localleader')
    let maplocalleader=g:spacevim_localleader
else
    let maplocalleader = ','
endif

function! Bootstrap()
    call LoadLayersPackage("packages.vim")
    call LoadLayersConfig("layers/", "config.vim")
    call LoadPrivateConfig("private/after_vimrc.vim")
endfunction

" Bootstrap space-vim
call Bootstrap()
