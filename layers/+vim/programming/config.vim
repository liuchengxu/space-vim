scriptencoding utf-8

if LayerLoaded('programming')

    function!  s:add_title()
        if &filetype == 'sh'
            call setline(1,'#!/usr/bin/env bash')
            call append(line('.'), '')
        elseif &filetype == 'python'
            call setline(1,'#!/usr/bin/env python')
            call append(line('.'), '# -*- coding: utf-8 -*-')
            call append(line('.')+1, '')
        elseif &filetype == 'ruby'
            call setline(1,'#!/usr/bin/env ruby')
            call append(line('.'), '# encoding: utf-8')
            call append(line('.')+1, '')
        elseif &filetype == 'cpp'
            call setline(1, '#include<iostream>')
            call append(line('.'), 'using namespace std;')
            call append(line('.')+1, '')
        elseif &filetype == 'c'
            call setline(1, '#include<stdio.h>')
            call append(line('.'), '')
        endif
    endfunction

    augroup SPACEVIM_NEWFILE
        autocmd BufNewFile *.py,*.rb,*.cpp,*.c,*.sh,*.java execute "call s:add_title()"
        autocmd BufNewFile * normal G
    augroup END

    " rainbow {
    if IsDir('rainbow')
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
    if IsDir('tagbar')
        let g:tagbar_autofocus = 1
        nmap <F6> :TagbarToggle<CR>
        imap <F6> <ESC>:TagbarToggle<CR>
        nnoremap <Leader>tt :TagbarToggle<CR>
    endif
    " }

    " asyncrun.vim {
    if IsDir('asyncrun.vim')
        nnoremap <F5> :call <SID>compile_and_run()<CR>
        augroup SPACEVIM_ASYNCRUN
            autocmd!
            autocmd User AsyncRunStart call asyncrun#quickfix_toggle(20, 1)
        augroup END
        function! s:compile_and_run()
            exec 'w'
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
    if IsDir('nerdcommenter')
        let g:NERDSpaceDelims=1

        nmap <Leader>;; <Plug>NERDCommenterToggle
        omap <Leader>;; <Plug>NERDCommenterToggle
        vmap <Leader>;; <Plug>NERDCommenterToggle
    endif
    " }

    " indentLine {
    if IsDir('indentLine')
        let g:indentLine_char='┊'
        let g:indentLine_enabled=1
        let g:indentLine_color_term=239
        let g:indentLine_concealcursor='vc' " default 'inc'
    endif
    " }

    " indent_guides {
    if IsDir('vim-indent-guides')
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
