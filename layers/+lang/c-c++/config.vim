if LayerLoaded('c-c++')

    if LayerLoaded('programming')
        autocmd Filetype c,cpp nnoremap <buffer> <LocalLeader>m :update<Bar>execute 'AsyncRun! make '.shellescape(@%, 1)<CR>
    else
        autocmd Filetype c,cpp nnoremap <buffer> <LocalLeader>m :update<Bar>execute '! make '.shellescape(@%, 1)<CR>
    endif

    augroup SPACEVIM_C
        autocmd!
        autocmd Filetype c,cpp setlocal cindent
    augroup END

    if IsDir('vim-cpp-enhanced-highlight')
        let g:cpp_class_scope_highlight = 1
        let g:c_no_curly_error=1
    endif


endif
