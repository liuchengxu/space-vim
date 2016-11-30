if index(g:layers_loaded, 'python') > -1

    autocmd FileType python setlocal foldmethod=indent

    if index(g:layers_loaded, 'programming') > -1
        autocmd Filetype python nnoremap <buffer> <F5> :update<Bar>execute 'AsyncRun! python '.shellescape(@%, 1)<CR>
        " formate code
        if executable('yapf')
            autocmd Filetype python nnoremap <buffer> <LocalLeader>= :update<Bar>execute 'AsyncRun! yapf '.shellescape(@%, 1)<CR>
        endif
    else
        autocmd Filetype python nnoremap <buffer> <F5> :update<Bar>execute '! python '.shellescape(@%, 1)<CR>
        if executable('yapf')
            autocmd Filetype python nnoremap <buffer> <LocalLeader>= :update<Bar>execute '! yapf '.shellescape(@%, 1)<CR>
        endif
    endif

endif
