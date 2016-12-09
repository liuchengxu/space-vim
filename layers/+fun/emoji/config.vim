if LayerLoaded('emoji')
    if isdirectory(expand(g:my_plug_home.'vim-emoji'))
        augroup emoji_complete
            autocmd!
            autocmd FileType markdown setlocal completefunc=emoji#complete
        augroup END
    endif
endif
