if index(g:layers_loaded, 'python') > -1

    augroup SPACEVIM_PYTHON
        autocmd!
        " Force indentation styles for python
        autocmd FileType python setlocal
                    \   foldmethod=indent
                    \   textwidth=79
                    \   shiftwidth=4
                    \   tabstop=4
                    \   softtabstop=4
                    \   expandtab
                    \   autoindent
                    \   fileformat=unix

        if index(g:layers_loaded, 'programming') > -1
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
