scriptencoding utf-8

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
        call setline(1, '#include <iostream>')
        call append(line('.'), 'using namespace std;')
        call append(line('.')+1, '')
    elseif &filetype == 'c'
        call setline(1, '#include <stdio.h>')
        call append(line('.'), '')
    endif
endfunction

augroup SPACEVIM_NEWFILE
    autocmd!
    autocmd BufNewFile *.py,*.rb,*.cpp,*.c,*.sh,*.java execute "call s:add_title()"
    autocmd BufNewFile * normal 2G
augroup END

" ultisnips {
    " Set ultisnips triggers
    let g:UltiSnipsSnippetDirectories=['UltiSnips']
    exe 'set rtp+=' . expand(g:spacevim_dir . '/private/UltiSnips')
    let g:UltiSnipsSnippetsDir = [g:spacevim_dir.'/private/UltiSnips', g:spacevim_plug_home.'vim-snippets/UltiSnips/']
    let g:UltiSnipsListSnippets = '<C-Tab>'
    let g:UltiSnipsJumpForwardTrigger = '<Tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
    " Fix tab conflict with YCM
    let g:UltiSnipsExpandTrigger = '<nop>'
    let g:ulti_expand_or_jump_res = 0
    function! ExpandSnippetOrCarriageReturn()
        let l:snippet = UltiSnips#ExpandSnippetOrJump()
        if g:ulti_expand_or_jump_res > 0
            return l:snippet
        else
            return "\<CR>"
        endif
    endfunction
    inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"
" }

" vim-move {
    " vim-move config
    " for terms that send Alt as Escape sequence
    " see http://vim.wikia.com/wiki/Mapping_fast_keycodes_in_terminal_Vim
    " for why the <F20> hack. Keeps Esc from waiting for other keys to exit visual
    set <F20>=j
    set <F21>=k
    vmap <F20> <Plug>MoveBlockDown
    vmap <F21> <Plug>MoveBlockUp
    nmap <F20> <Plug>MoveLineDown
    nmap <F21> <Plug>MoveLineUp
" }

" rainbow {
    let g:rainbow_active = 1
    let g:rainbow_conf = {
                \   'guifgs': [ '#8FBC8F', '#48D1CC', '#DEB887', '#FFA07A', 'seagreen3', '#66CDAA', '#FFB6C1'],
                \   'ctermfgs': ['98', '133', '140', '169'],
                \   'operators': '_,_',
                \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
                \   'separately': {
                \       '*': {},
                \       'tex': {
                \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
                \       },
                \       'lisp': {
                \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', '#FF69B4', '#DDA0DD', '#F08080', '#FF8C00', '#20B2AA'],
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
" }

" rainbow_parentheses.vim {
    augroup rainbow_lisp
        autocmd!
        autocmd FileType lisp,clojure,scheme RainbowParentheses
    augroup END
" }

" tagbar {
    let g:tagbar_autofocus = 1
    nnoremap <F6> :TagbarToggle<CR>
    inoremap <F6> <ESC>:TagbarToggle<CR>
    nnoremap <Leader>tt :TagbarToggle<CR>
    let g:tagbar_sort = 0
" }

" asyncrun.vim {
    nnoremap <F5> :call <SID>compile_and_run()<CR>
    augroup SPACEVIM_ASYNCRUN
        autocmd!
        autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
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
        elseif &filetype == 'ruby'
            exec "AsyncRun! time ruby %"
        endif
    endfunction
" }

" nerdcommenter {
    let g:NERDSpaceDelims=1

    nmap <Leader>;; <Plug>NERDCommenterToggle
    omap <Leader>;; <Plug>NERDCommenterToggle
    vmap <Leader>;; <Plug>NERDCommenterToggle
" }

" indentLine {
    let g:indentLine_char='¦'
    let g:indentLine_enabled=1
    let g:indentLine_color_term=239
    let g:indentLine_color_gui = '#4A9586'
    let g:indentLine_concealcursor='vc'      " default 'inc'
    let g:indentLine_fileTypeExclude = ['help', 'startify', 'vimfiler']
" }

" vim-indent-guides {
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_auto_colors = 0
    nnoremap <Leader>ti :IndentGuidesToggle<CR>
" }

" vim-polyglot {
    " Reset errorformat to its default value for cooperating with asyncrun.vim
    autocmd BufEnter * set errorformat&
" }

" vim-swoop {
    " Do not let vim-swoop create keybindings
    let g:swoopUseDefaultKeyMap = 0
    " Visual selection mode mapping: swoop current selection.
    vmap <Leader>s :call SwoopMultiSelection()<CR>
    " Normal mode mapping:
    "   <Leader>ss to start swoop buffer.
    "   <Leader>sm to swoop in multiple buffers.
    nnoremap <Leader>ss :call Swoop()<CR>
    nnoremap <Leader>sm :call SwoopMulti()<CR>
" }
