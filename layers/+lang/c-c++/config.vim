if index(g:layers_loaded, 'programming') > -1
    let s:SHELL_COMMAND = 'AsyncRun!'
else
    let s:SHELL_COMMAND = '!'
endif

if index(g:layers_loaded, 'c-c++') > -1
    autocmd Filetype c,cpp nnoremap <buffer> <F5> :update<Bar>execute 'AsyncRun! make '.shellescape(@%, 1)<CR>
else
    autocmd Filetype c,cpp nnoremap <buffer> <F5> :update<Bar>execute '! make '.shellescape(@%, 1)<CR>
endif


