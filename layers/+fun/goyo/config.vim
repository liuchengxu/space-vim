if LayerLoaded('goyo')
" Limelight settings
    " Color name (:help cterm-colors) or ANSI code
    let g:limelight_conceal_ctermfg = 238

    " Color name (:help gui-colors) or RGB color
    let g:limelight_conceal_guifg = '#777777'

    " Default: 0.5
    let g:limelight_default_coefficient = 0.9

    "Goyo.vim & Limelight.vim integration
    augroup SPACEVIM_GOYO
        autocmd! User GoyoEnter Limelight
        autocmd! User GoyoLeave Limelight!
    augroup END
endif

