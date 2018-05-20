if g:spacevim.os.mac
    " You need to run: defaults write TeXShop BringPdfFrontOnAutomaticUpdate NO
    let g:spacevim#plug#latex#Previewer = 'open -a texshop'
elseif g:spacevim.os.linux
    let g:spacevim#plug#latex#Previewer = 'evince'
endif
