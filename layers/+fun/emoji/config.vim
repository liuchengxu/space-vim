if index(g:layers_loaded, 'emoji')
    if isdirectory(expand("~/.vim/plugged/vim-emoji"))
        set completefunc=emoji#complete
    endif
endif
