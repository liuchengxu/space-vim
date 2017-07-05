" vim-emoji {
  augroup spacevimEmoji
    autocmd!
    autocmd FileType markdown setlocal completefunc=emoji#complete
  augroup END
" }
