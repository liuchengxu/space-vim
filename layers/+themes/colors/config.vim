if LayerLoaded('colors')

    " space-vim-dark {
    if isdirectory(expand(g:my_plug_home.'space-vim-dark'))
        color space-vim-dark
    endif
    " }

    " vim-airline {
    if isdirectory(expand(g:my_plug_home.'vim-airline'))
        " let g:airline_theme="luna"
        let g:airline_theme='violet'
        " let g:airline_theme="powerlineish"
        let g:Powerline_symbols='fancy'
        " use powerline font. If not, let g:airline_powerline_fonts=0
        let g:airline_powerline_fonts=0
        let g:airline#extensions#default#layout = [
                    \ [ 'a', 'b', 'c' ],
                    \ [ 'x', 'y', 'z', 'error', 'warning' ]
                    \ ]
        " let g:airline_section_x = '%>%ft'
        " let g:airline_section_y = '%{strftime("%H:%M")}'
        let g:airline#extensions#tabline#enabled=1
        let g:airline#extensions#tabline#buffer_nr_show=1
        " let g:airline#extensions#whitespce#enabled=0
        " let g:airline#extensions#whitespace#symbol='!'
        " let g:airline#extensions#whitespace#mixed_indent_algo=2
        if !exists('g:airline_powerline_fonts')
            let g:airline_left_sep='>'
            let g:airline_right_sep='<'
        endif
    endif

    " }

endif

