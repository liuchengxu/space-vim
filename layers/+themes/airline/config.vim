if LayerLoaded('airline')

    " vim-airline {
    if IsDir('vim-airline')
        let g:airline_theme='violet'
        let g:Powerline_symbols='fancy'
        " use powerline font. If not, let g:airline_powerline_fonts=0
        let g:airline_powerline_fonts=1
        let g:airline#extensions#default#layout = [
                    \ [ 'a', 'b', 'c' ],
                    \ [ 'x', 'y', 'z', 'error', 'warning' ]
                    \ ]
        let g:airline#extensions#tabline#enabled=1
        let g:airline#extensions#tabline#buffer_nr_show=1
        if !exists('g:airline_powerline_fonts')
            let g:airline_left_sep='>'
            let g:airline_right_sep='<'
        endif
    endif

    " }
endif

