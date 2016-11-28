if index(g:layers_loaded, 'python') > -1
    autocmd Filetype python nnoremap <buffer> <F5> :update<Bar>execute 'AsyncRun! python '.shellescape(@%, 1)<CR>
else
    autocmd Filetype python nnoremap <buffer> <F5> :update<Bar>execute '! python '.shellescape(@%, 1)<CR>
endif

