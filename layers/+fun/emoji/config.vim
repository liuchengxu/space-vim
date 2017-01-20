" vim-emoji {
    augroup SPACEVIM_EMOJI
        autocmd!
        autocmd FileType markdown setlocal completefunc=emoji#complete
    augroup END
" }
