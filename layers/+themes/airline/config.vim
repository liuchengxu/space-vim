if LayerLoaded('airline')

    " vim-airline {
    if IsDir('vim-airline')
        let g:airline_theme='violet'
        let g:Powerline_symbols='fancy'
        let g:airline#extensions#default#section_truncate_width = {
                    \ 'b': 79,
                    \ 'x': 60,
                    \ 'y': 88,
                    \ 'z': 45,
                    \ 'warning': 80,
                    \ 'error': 80,
                    \ }
        let g:airline#extensions#default#layout = [
                    \ [ 'a', 'error', 'warning', 'b', 'c' ],
                    \ [ 'x', 'y', 'z' ]
                    \ ]
        let g:airline#extensions#tabline#enabled=1
        let g:airline#extensions#tabline#buffer_nr_show=1

        " use powerline font. If not, let g:airline_powerline_fonts=0
        let g:airline_powerline_fonts=1
        if !exists('g:airline_powerline_fonts')
            let g:airline_left_sep='>'
            let g:airline_right_sep='<'
        endif
    endif

    " }
endif

