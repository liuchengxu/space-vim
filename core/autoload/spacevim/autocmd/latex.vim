if g:spacevim.os.mac
    " You need to run: defaults write TeXShop BringPdfFrontOnAutomaticUpdate NO
    let s:previewer = 'open -a texshop'
elseif g:spacevim.os.linux
    let s:previewer = 'evince'
endif

function! spacevim#autocmd#latex#Init()
" vim-latex-live-preview {
  let g:livepreview_previewer = s:previewer
" }
endfunction
