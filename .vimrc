" Environment {

    " Identify platform{
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

    " Basics {
        set nocompatible              " Must be the first line
    " }

" }

" Plugins List {
    if filereadable(expand("~/.vimrc.plug.list"))
        source ~/.vimrc.plug.list
    endif
" }

" General {

    set background=dark
    " This makes vim act like all other editores, buffers can
    " exist in the background without being in a window.
    set hidden

    " Use Unix as the standard file type
    set ffs=unix,dos,mac

    set encoding=utf-8
    set termencoding=utf-8
    set langmenu=zh-CN.UTF-8
    set fileencoding=utf-8
    set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

    syntax enable      " turn on syntax highlighting
    syntax on          " 自动语法高亮

    filetype on
    filetype plugin indent on

    set autoread
    set autowrite

    set mouse=a
    set selection=exclusive
    set selectmode=mouse,key

    " set paste会导致YCM的tab补全失效, delimitMate失效
    " set paste

    set history=10000

    set nobackup
    set noswapfile
    set nowb

    set report=0

    set wildignore+=*swp,*.pyc,*.png,*.jpg,*.gif
    set wildignore+=*/tmp/*,*.so,*.zip     " MacOSX/Linux
    set wildignore+=*\\tmp\\*,*.zip,*.exe  " Windows

    set completeopt=longest,menu

    " 共享系统剪贴板
    set clipboard=unnamed

    if has('persistent_undo')
        set undofile
        set undolevels=1000
        set undoreload=10000
    endif
" }

" VIM UI {

    set t_Co=256       " required for airline

    set ruler
    set showcmd
    set showmode

    set cursorline      " Highlight current line
    set cursorcolumn    " Highlight current column
    hi CursorLine ctermbg=240
    hi CursorColumn ctermbg=240
    set laststatus=2    " Always show status line, required for airline

    set backspace=2

    set foldenable
    set foldmarker={,}
    set foldlevel=0
    set foldmethod=marker
    set foldcolumn=3

    set winminheight=0
    set wildmode=list:longest,full
    set wildmenu                    " vim自身命令行模式智能补全
    set scrolljump=5
    set scrolloff=3

    set nowrap       " Don't wrap lines
    set linebreak    " Wrap lines at convennient points

    set hlsearch     " Find the next match as we type the search
    set incsearch    " Highlight searches by default
    set ignorecase   " Ignore case when searching...
    set smartcase    " ...unless we type a capital

    set viminfo+=!
    set backspace=indent,eol,start
    set linespace=0
    set number                      " 显示行号
    set relativenumber              " 启用相对行号
    set showmatch                   " 显示括号匹配情况
    set matchtime=5                 " 显示括号匹配时间
    set listchars=tab:→\ ,eol:↵,trail:·,extends:↷,precedes:↶

" }

" Formatting {

    set cindent
    set autoindent
    set smartindent
    set expandtab
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4

" }

" Key (re)Mappings {

    " Better defaults {
        let mapleader="\<Space>"
        let maplocalleader=","
        map <Leader>sa ggVG
        map <leader>' :shell<CR>
        nmap <leader>q  :q<CR>
        nmap <leader>Q  :qa!<CR>
        nmap <leader>d  <C-d>
        nmap <leader>u  <C-u>
        "insert mode shortcut
        inoremap <C-h> <Left>
        inoremap <C-j> <Down>
        inoremap <C-k> <Up>
        inoremap <C-l> <Right>
        inoremap <C-d> <DELETE>
        imap jj <Esc>
        imap jk <Esc>
        imap kk <Esc>
        imap ;; <Esc>
        " Remap H to the start of line
        nnoremap H ^
        " Remap L to the end of line
        nnoremap L $
        " Redo
        nnoremap U <C-r>
        " Yank to the end of line
        nnoremap Y y$
        " Auto indent pasted text, 自动缩进粘贴文本
        nnoremap p p=`]<C-o>
        " 调整缩进后自动选中，方便再次操作
        vnoremap < <gv
        vnoremap > >gv
        " Treat long lines ad break lines (useful when moving around in them)
        map j gj
        map k gk
        " 当遇到没有行号的行时，gj/gk 命令会使光标按虚拟行移动，而当遇到有行号的行时，光标则按物理行移动。
        noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
        noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
        " 映射全选加复制 Ctrl+a
        map <C-a> ggVGY
        map! <C-a> <Esc>ggVGY
        " Ctrl+c 复制，Ctrl+v 粘贴
        map <C-c> "+y
        map <C-v> "+p
        " 搜索完后按<leader>sc, search highlight cancel, 即可去掉高亮
        map <Leader>sc :nohl<CR>       " 搜索完成后去掉搜索结果高亮
        " Show hidden chars hidden emerge
        nmap <Leader>he :set list!<CR>  " 显示不可见字符
        " Toggle paste mode on and off
        nnoremap <Leader>tp :setlocal paste!<CR>
        " Pressing ss will toggle and untoggle spell checking
        map <Leader>ss :setlocal spell!<CR>
        " :W sudo saves the file
        " (useful for handling the permission-denied error)
        command! W w !sudo tee % > /dev/null
    " }

    " File & Fold {
        nmap <Leader>fs :w<CR>
        nmap <Leader>fv :e ~/.vimrc<CR>
        nmap <Leader>fc :e ~/.vimrc.plug.conf<CR>
        nmap <Leader>fl :e ~/.vimrc.plug.list<CR>
        nmap <Leader>fR :source $MYVIMRC<CR>

        " Code folding options
        nmap <Leader>f0 :set foldlevel=0<CR>
        nmap <Leader>f1 :set foldlevel=1<CR>
        nmap <Leader>f2 :set foldlevel=2<CR>
        nmap <Leader>f3 :set foldlevel=3<CR>
        nmap <Leader>f4 :set foldlevel=4<CR>
        nmap <Leader>f5 :set foldlevel=5<CR>
        nmap <Leader>f6 :set foldlevel=6<CR>
        nmap <Leader>f7 :set foldlevel=7<CR>
        nmap <Leader>f8 :set foldlevel=8<CR>
        nmap <Leader>f9 :set foldlevel=9<CR>
    " }

    " Window {
        nmap <Leader>ww <C-W>w
        nmap <Leader>wr <C-W>r
        nmap <Leader>wd <C-W>c
        nmap <Leader>wq <C-W>q
        nmap <Leader>wj <C-W>j
        nmap <Leader>wk <C-W>k
        nmap <Leader>wh <C-W>h
        nmap <Leader>wl <C-W>l
        nmap <Leader>ws <C-W>s
        nmap <Leader>w- <C-W>s
        nmap <Leader>wv <C-W>v
        nmap <Leader>w\| <C-W>v
        nmap <Leader>w2 <C-W>v
    " }

    " Buffer {
        nnoremap <Leader>bb :buffers<CR>
        nnoremap <Leader>bp :bprevious<CR>
        nnoremap <Leader>bn :bnext<CR>
        nnoremap <Leader>bf :bfirst<CR>
        nnoremap <Leader>bl :blast<CR>
        nnoremap <Leader>bd :bd<CR>
        nnoremap <Leader>bk :bw<CR>
        nnoremap <Leader>1 :b1<CR>
        nnoremap <Leader>2 :b2<CR>
        nnoremap <Leader>3 :b3<CR>
        nnoremap <Leader>4 :b4<CR>
        nnoremap <Leader>5 :b5<CR>
        nnoremap <Leader>6 :b6<CR>
        nnoremap <Leader>7 :b7<CR>
        nnoremap <Leader>8 :b8<CR>
        nnoremap <Leader>9 :b9<CR>
    " }

    " Autocmd {
    if has("autocmd")
        " 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
        autocmd BufRead,BufNewFile *.html set shiftwidth=2
        autocmd BufRead,BufNewFile *.c,*.cpp,*.h,*.py set shiftwidth=4
        autocmd BufNewFile *.py,*.rb,*.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()"
        function!  SetTitle()
            if &filetype == 'sh'
                call setline(1,"#!/usr/bin/env bash")
                call append(line("."), "")
            elseif &filetype == 'python'
                call setline(1,"#!/usr/bin/env python")
                call append(line("."), "# -*- coding: utf-8 -*-")
                call append(line(".")+1, "")
            elseif &filetype == 'ruby'
                call setline(1,"#!/usr/bin/env ruby")
                call append(line("."), "# encoding: utf-8")
                call append(line(".")+1, "")
            elseif &filetype == 'cpp'
                call setline(1, "#include<iostream>")
                call append(line("."), "using namespace std;")
                call append(line(".")+1, "")
            elseif &filetype == 'c'
                call setline(1, "#include<stdio.h>")
                call append(line("."), "")
            endif
            normal G
            normal o
        endfunction
    endif
    " }

    " F keys {
        " mac
        nnoremap <F8> :w<cr>:!dot -Teps -o %<.eps % && open %<.eps<CR><CR>
        " ubuntu
        " nnoremap <F8> :w<cr>:!dot -Teps -o %<.eps % && evince %<.eps<CR><CR>
    " }

" }

" Plugins Configuration {
    if filereadable(expand("~/.vimrc.plug.conf"))
        source ~/.vimrc.plug.conf
    endif
" }

" Functions {

    " 默认情况下F1为打开vim的内置帮助
    " F5分配给编译运行功能
    nnoremap <F5> :call CompileAndRun()<CR>
    nnoremap <silent><Leader>cC :call CompileAndRun()<CR>
    function! CompileAndRun()
        exec "w"
        if &filetype == 'c'
            exec "!gcc % -o %<"
            exec "!time ./%<"
        elseif &filetype == 'cpp'
            exec "!g++ -std=c++11 % -o %<"
            exec "!time ./%<"
        elseif &filetype == 'java'
            exec "!javac %"
            exec "!time java %<"
        elseif &filetype == 'sh'
            :!time bash %
        elseif &filetype == 'python'
            exec "!time python %"
        endif
    endfunction

    " 切换行号显示模式
    nnoremap <Leader>tn :call ToggleLineNumber()<CR>
    function! ToggleLineNumber()
        if &number
            set nonumber
            set norelativenumber
        else
            set number
            set relativenumber
        endif
    endfunction
    nnoremap <Leader>tr :call ToggleRelativeLineNumber()<CR>
    function! ToggleRelativeLineNumber()
        if &number
            if &relativenumber
                set norelativenumber
            else
                set relativenumber
            endif
        else
            set number
            set relativenumber
        endif
    endfunction

    " GUI 环境下最大化开关
    let s:lines=&lines
    let s:columns=&columns
    function! FullScreenEnter()
        set lines=999 columns=999
        set fullscreen
    endfunction

    function! FullScreenLeave()
        let &lines=s:lines
        let &columns=s:columns
        set nofullscreen
    endfunction

    function! FullScreenToggle()
        if &fullscreen
            call FullScreenLeave()
        else
            call FullScreenEnter()
        endif
    endfunction
" }

" GUI Settings {

    if has("gui_running")
        " 解决菜单栏乱码
        let $LANG = 'zh_CN.UTF-8'
        set langmenu=zh_CN
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        set guioptions-=r       " 隐藏右侧滚动条
        set guioptions-=L       " 隐藏左侧滚动条
        set guioptions-=T
        set guioptions-=e
        " No annoying sound on errors
        set noerrorbells
        set novisualbell
        set t_vb=
        " GUI 最大化快捷键
        nnoremap <Leader>wm :call FullScreenToggle()<CR>
        " windows GUI界面乱码设置
        if WINDOWS() && has("gui_running")
            "处理consle输出乱码
            language messages zh_CN.utf-8
            " Set extra options when running in GUI mode
            set guifont=Consolas:h13
            " set guifont＝Source\ Code\ Pro\ for\ Powerline
            if has("gui_gtk2")   "GTK2
                set guifont=Monaco\ 12,Monospace\ 12
            endif
            set guitablabel=%M\ %t
            " set showtabline=1
            " set guioptions+=e   " 这两个设置会使得airline上方的buffer无法显示
            set linespace=2
            set noimd
        elseif OSX() && has("gui_running")
            " set guifont=Cousine\ for\ Powerline:h13
            set guifont=Roboto\ Mono\ Light\ for\ Powerline:h13
            set shortmess+=c
            set lines=100 columns=90
        endif
    endif

" }

" Use local vimrc if exists {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }

" Use local gvimrc if exists {
    if filereadable(expand("~/.gvimrc.local"))
        source ~/.gvimrc.local
    endif
" }
