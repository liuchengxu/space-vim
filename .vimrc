if !exists('g:default_layers')
    let g:default_layers={
                \ 'fzf' : 't',
                \ 'ycmd' : 't',
                \ 'unite' : 't',
                \ 'markdown' : 't',
                \ 'better-defaults' : 't',
                \ 'syntax-checking' : 'ale',
                \ 'text-align' : 'vim-easy-align',
                \}
endif

" Plugins List {
    if filereadable(expand("~/.space-vim/packages.vim"))
        source ~/.space-vim/packages.vim
    endif
" }

" Key (re)Mappings {

    " Better defaults {
        let mapleader="\<Space>"
        let maplocalleader=","

        set fillchars=""
        nnoremap ; :
         " 映射全选加复制 Ctrl+a
        map <C-a> ggVGY
        map! <C-a> <Esc>ggVGY
        " Ctrl+c 复制，Ctrl+v 粘贴
        map <C-c> "+y
        map <C-v> "+p
        " Show hidden chars hidden emerge
        nnoremap <Leader>he :set list!<CR>
        " Pressing ss will toggle and untoggle spell checking
        map <Leader>ss :setlocal spell!<CR>

        " formate python
        nnoremap <LocalLeader>= :!yapf %<CR>
    " }

    " File {
        nnoremap <Leader>fR :source $MYVIMRC<CR>
    " }

    " Autocmd {
    if has("autocmd")
        " 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
        autocmd FileType html set shiftwidth=2
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
    if filereadable(expand("~/.space-vim/config.vim"))
        source ~/.space-vim/config.vim
    endif
" }

" Functions {

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


" GUI Settings {

    if has("gui_running")
        " 解决菜单栏乱码
        let $LANG = 'zh_CN.UTF-8'
        set langmenu=zh_CN
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        highlight Cursor guifg=black guibg=#dfff00
        highlight iCursor guifg=black guibg=white
        highlight vCursor guifg=black guibg=#df5f00
        set guicursor=n-v-c:block-Cursor
        " set guicursor+=i:ver100-iCursor
        set guicursor+=n-v-c:blinkon0
        " set guicursor+=i:blinkwait10
        set guicursor=i:ver1
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
            set lines=100 columns=90
            " GUI 最大化快捷键
            nnoremap <Leader>wm :call FullScreenToggle()<CR>
        endif
    endif

" }

" Use local vimrc if exists {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }
