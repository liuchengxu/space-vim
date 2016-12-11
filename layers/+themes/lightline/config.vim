if LayerLoaded('lightline')

    " lightline.vim {
    if isdirectory(expand(g:my_plug_home.'lightline.vim'))
        let g:lightline = {
                    \ 'colorscheme': 'wombat',
                    \ }
    endif

    " }
endif

