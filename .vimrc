if filereadable(expand("~/.vimrc.before"))
    source ~/.vimrc.before
endif

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

if !exists('g:spacevim_leader')
    let mapleader = "\<Space>"
else
    let mapleader=g:spacevim_leader
endif

if !exists('g:spacevim_localleader')
    let maplocalleader = ','
else
    let maplocalleader=g:spacevim_localleader
endif

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

" Setup tools {
    " Load the plugins for layers {
    function! LoadLayersPackage()
        if filereadable(expand("~/.space-vim/packages.vim"))
            source ~/.space-vim/packages.vim
        endif
    endfunction
    " }

    " Load configuration file for layers {
    function! LoadLayersConfig()
        let s:layers_dir = "~/.space-vim/layers/"
        let s:config_path = "/config.vim"
        for [key, val] in items(g:default_layers)
            let s:config_file = s:layers_dir . key . s:config_path
            if filereadable(expand(s:config_file))
                execute "source " . fnameescape(s:config_file)
            else
                echom "config.vim for layer " . key . " is not available, please check it."
            endif
        endfor
    endfunction
    " }

    " Load local config id available {
    function! LoadLocalConfig()
        if filereadable(expand("~/.vimrc.local"))
            source ~/.vimrc.local
        endif
    endfunction
    " }

    function! Bootstrap()
        call LoadLayersPackage()
        call LoadLayersConfig()
        call LoadLocalConfig()
    endfunction
" }

" Bootstrap space-vim
call Bootstrap()
