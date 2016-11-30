if index(g:layers_loaded, 'fzf') > -1
    " fzf.vim {
    if isdirectory(expand("~/.vim/plugged/fzf.vim"))
        nnoremap <Leader>bb :Buffers<CR>
    endif
    " }
endif

