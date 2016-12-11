if LayerLoaded('emoji')
    if IsDir('vim-emoji')
        augroup emoji_complete
            autocmd!
            autocmd FileType markdown setlocal completefunc=emoji#complete
        augroup END
    endif
endif
