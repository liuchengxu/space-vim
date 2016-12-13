if LayerLoaded('latex')
    if IsDir('vim-latex-live-preview')
        autocmd Filetype tex setlocal updatetime=1
        if OSX()
            " You need to run: defaults write TeXShop BringPdfFrontOnAutomaticUpdate NO
            let g:livepreview_previewer = 'open -a texshop'
        elseif LINUX()
            let g:livepreview_previewer = 'evince'
        endif
    endif
endif
