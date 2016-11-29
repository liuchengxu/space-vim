if index(g:layers_loaded, 'c-c++') > -1

    if index(g:layers_loaded, 'programming') > -1
        let s:SHELL_COMMAND = 'AsyncRun!'
    else
        let s:SHELL_COMMAND = '!'
    endif

    autocmd Filetype c,cpp nnoremap <buffer> <F5> :update<Bar>execute s:SHELL_COMMAND . ' make '.shellescape(@%, 1)<CR>

endif
