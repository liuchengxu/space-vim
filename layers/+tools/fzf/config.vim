if index(g:layers_loaded, 'fzf') > -1
    " fzf.vim {
    if isdirectory(expand(g:my_plug_home.'fzf.vim'))
        nnoremap <Leader>bb :Buffers<CR>
    endif
    " }
endif

