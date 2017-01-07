if LayerLoaded('leader-guide')
    call leaderGuide#register_prefix_descriptions(g:mapleader, 'g:lmap')
    nnoremap <silent> <leader> :<c-u>LeaderGuide g:mapleader<CR>
    vnoremap <silent> <leader> :<c-u>LeaderGuideVisual g:mapleader<CR>
endif
