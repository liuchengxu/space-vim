if LayerLoaded('python')

    function! s:hi_over_length()
        highlight OverLength ctermbg=133 ctermfg=254 cterm=bold guibg=#592929
        match OverLength /\%81v.\+/
    endfunction

    augroup SPACEVIM_PYTHON
        autocmd!
        " Force indentation styles for python
        autocmd FileType python setlocal
                    \   foldmethod=indent
                    \   tabstop=4
                    \   shiftwidth=4
                    \   softtabstop=4
                    \   textwidth=79
                    \   expandtab
                    \   autoindent
                    \   fileformat=unix

        autocmd FileType python nnoremap <LocalLeader>ho :call <SID>hi_over_length()<CR>

        if LayerLoaded('programming')
            autocmd FileType python nnoremap <buffer> <F5> :update<Bar>execute 'AsyncRun! python '.shellescape(@%, 1)<CR>
        else
            autocmd FileType python nnoremap <buffer> <F5> :update<Bar>execute '! python '.shellescape(@%, 1)<CR>
        endif

        if executable('yapf')
            autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>
        else
            autocmd FileType python nnoremap <LocalLeader>= echom '[space-vim] yapf is unavailable, please install it first.'
        endif

    augroup END

endif
