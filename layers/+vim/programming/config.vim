scriptencoding utf-8

if index(g:layers_loaded, 'programming') > -1

    function!  AddTitle()
        if &filetype ==? 'sh'
            call setline(1,'#!/usr/bin/env bash')
            call append(line('.'), '')
        elseif &filetype ==? 'python'
            call setline(1,'#!/usr/bin/env python')
            call append(line('.'), '# -*- coding: utf-8 -*-')
            call append(line('.')+1, '')
        elseif &filetype ==? 'ruby'
            call setline(1,'#!/usr/bin/env ruby')
            call append(line('.'), '# encoding: utf-8')
            call append(line('.')+1, '')
        elseif &filetype ==? 'cpp'
            call setline(1, '#include<iostream>')
            call append(line('.'), 'using namespace std;')
            call append(line('.')+1, '')
        elseif &filetype ==? 'c'
            call setline(1, '#include<stdio.h>')
            call append(line('.'), '')
        endif
    endfunction

    augroup SPACEVIM_NEWFILE
        " TODO: error occurs
        " autocmd BufNewFile *.py,*.rb,*.cpp,*.c,*.sh,*.java execute "call AddTitle()"
        autocmd BufNewFile * normal G
    augroup END

    " rainbow {
    if isdirectory(expand('~/.vim/plugged/rainbow'))
        let g:rainbow_active = 1
        let g:rainbow_conf = {
                    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
                    \   'ctermfgs': ['blue', 'gray', 'cyan', 'magenta'],
                    \   'operators': '_,_',
                    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
                    \   'separately': {
                    \       '*': {},
                    \       'tex': {
                    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
                    \       },
                    \       'lisp': {
                    \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
                    \       },
                    \       'vim': {
                    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
                    \       },
                    \       'html': {
                    \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
                    \       },
                    \       'css': 0,
                    \   }
                    \}
    endif
    " }

    " tagbar {
    if isdirectory(expand("~/.vim/plugged/tagbar"))
        let g:tagbar_autofocus = 1
        nmap <F6> :TagbarToggle<CR>
        imap <F6> <ESC>:TagbarToggle<CR>
    endif
    " }

    " asyncrun.vim {
    if isdirectory(expand("~/.vim/plugged/asyncrun.vim"))
        nnoremap <F5> :call CompileAndRun()<CR>
        augroup SPACEVIM_ASYNCRUN
            autocmd!
            autocmd User AsyncRunStart call asyncrun#quickfix_toggle(20, 1)
        augroup END
        function! CompileAndRun()
            exec "w"
            if &filetype == 'c'
                exec "AsyncRun! gcc % -o %<; time ./%<"
            elseif &filetype == 'cpp'
                exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
            elseif &filetype == 'java'
                exec "AsyncRun! javac %; time java %<"
            elseif &filetype == 'sh'
                exec "AsyncRun! time bash %"
            elseif &filetype == 'python'
                exec "AsyncRun! time python %"
            endif
        endfunction
    endif
    " }

    " nerdcommenter {
    if isdirectory(expand("~/.vim/plugged/nerdcommenter"))
        let NERDSpaceDelims=1

        nmap <Leader>;; <Plug>NERDCommenterToggle
        omap <Leader>;; <Plug>NERDCommenterToggle
        vmap <Leader>;; <Plug>NERDCommenterToggle
    endif
    " }

    " indentLine {
    if isdirectory(expand("~/.vim/plugged/indentLine"))
        let g:indentLine_char='┊'
        let g:indentLine_enabled=1
        let g:indentLine_color_term=239
        let g:indentLine_concealcursor='vc' " default 'inc'

        map <F9> :IndentLinesToggle<CR>
        imap <F9> <ESC>:IndentLinesToggle<CR>
    endif
    " }

    " indent_guides {
    if isdirectory(expand("~/.vim/plugged/vim-indent-guides/"))
        let g:indent_guides_start_level = 2
        let g:indent_guides_guide_size = 1
        let g:indent_guides_enable_on_vim_startup = 1
        let g:indent_guides_auto_colors = 0
        autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=237
        autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=239
        nnoremap <Leader>ti :IndentGuidesToggle<CR>
    endif
    " }

endif
