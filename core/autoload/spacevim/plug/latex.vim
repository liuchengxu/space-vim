if g:MAC
    " You need to run: defaults write TeXShop BringPdfFrontOnAutomaticUpdate NO
    let g:spacevim#plug#latex#Previewer = 'open -a texshop'
elseif g:LINUX
    let g:spacevim#plug#latex#Previewer = 'evince'
endif
