MP 'unblevable/quick-scope'

MP 'justinmk/vim-sneak', { 'lazy': g:spacevim.speed_up_via_timer }
MP 'easymotion/vim-easymotion', { 'lazy': g:spacevim.speed_up_via_timer }
MP 'haya14busa/incsearch-easymotion.vim', {
  \ 'lazy': g:spacevim.speed_up_via_timer, 'on_map': [
    \ '<Plug>(easymotion-prefix)',
    \ '<Plug>(easymotion-bd-f)',
    \ '<Plug>(easymotion-overwin-f)',
    \ '<Plug>(easymotion-overwin-f2)',
    \ '<Plug>(easymotion-bd-jk)',
    \ '<Plug>(easymotion-overwin-line)',
    \ '<Plug>(easymotion-bd-w)',
    \ '<Plug>(easymotion-overwin-w)',
    \ ]
  \ }
