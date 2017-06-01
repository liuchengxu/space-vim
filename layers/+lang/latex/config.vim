" vim-latex-live-preview {
  autocmd Filetype tex setlocal updatetime=1

  if g:MAC
    " You need to run: defaults write TeXShop BringPdfFrontOnAutomaticUpdate NO
    let g:livepreview_previewer = 'open -a texshop'
  elseif g:LINUX
    let g:livepreview_previewer = 'evince'
  endif
" }
