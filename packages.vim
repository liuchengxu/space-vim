" Plugins list {

    " Load vim-plug
    if empty(glob("~/.vim/autoload/plug.vim"))
        execute '!curl -fLo ~/.vim/autoload/plug.vim
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    endif

    call plug#begin('~/.vim/plugged')

    if get(g:default_layers, 'better-defaults') ==? 't'
        Plug 'liuchengxu/vim-better-default'
        Plug 'liuchengxu/space-vim-dark'
        Plug 'SirVer/ultisnips'
        Plug 'honza/vim-snippets'
        Plug 'vim-airline/vim-airline-themes'
        Plug 'vim-airline/vim-airline'

        Plug 'Raimondi/delimitMate'
        Plug 'tpope/vim-surround'
        Plug 'easymotion/vim-easymotion'

        Plug 'Shougo/denite.nvim'
        Plug 'Shougo/unite.vim'

        Plug 'mhinz/vim-startify'
        Plug 'scrooloose/nerdtree',                     { 'on': 'NERDTreeToggle' }
        Plug 'Xuyuanp/nerdtree-git-plugin',             { 'on': 'NERDTreeToggle' }
        Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }

        Plug 'skywind3000/asyncrun.vim', { 'on': ['AsyncRun'] }
        Plug 'bronson/vim-trailing-whitespace', { 'on': 'FixWhitespace' }
    endif

    if get(g:default_layers, 'programming') ==? 't'
        Plug 'nathanaelkane/vim-indent-guides', { 'for': ['shell', 'python', 'java', 'c', 'cpp'] }
        Plug 'scrooloose/nerdcommenter'
        Plug 'luochen1990/rainbow'
        if executable('ctags')
            " Do not lazy loading tagbar, see vim-airline issue 1313.
            Plug 'majutsushi/tagbar'
        endif
    endif

    if get(g:default_layers, 'markdown') ==? 't'
        Plug 'plasticboy/vim-markdown',  { 'for': 'markdown' }
        Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown' }
    endif

    if get(g:default_layers, 'fzf') ==? 't'
        Plug 'junegunn/fzf.vim'
        Plug 'junegunn/fzf',             { 'dir': '~/.fzf', 'do': './install --all' }
    endif

    if get(g:default_layers, 'text-align') ==? 'tabular'
        Plug 'godlygeek/tabular'
    else
        Plug 'junegunn/vim-easy-align',  { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
    endif

    if get(g:default_layers, 'syntax-checking') ==? 'ale'
        Plug 'w0rp/ale'
    else
        Plug 'scrooloose/syntastic'
    endif

    if get(g:default_layers, 'ycmd') ==? 't'
        function! BuildYCM(info)
            " info is a dictionary with 3 fields
            " - name:   name of the plugin
            " - status: 'installed', 'updated', or 'unchanged'
            " - force:  set on PlugInstall! or PlugUpdate!
            if a:info.status == 'installed' || a:info.force
                !./install.py --clang-completer
            endif
        endfunction
        Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
    endif


    if filereadable(expand("~/.vimrc.plug.local"))
        source ~/.vimrc.plug.local
    endif

    call plug#end()

" }
