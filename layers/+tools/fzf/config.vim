if index(g:layers_loaded, 'fzf')
    " fzf.vim {
    if isdirectory(expand("~/.vim/plugged/fzf.vim"))
        nnoremap <Leader>bb :Buffers<CR>
    endif
    " }
endif

