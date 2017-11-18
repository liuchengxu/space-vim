if g:spacevim_vim8 || g:spacevim_nvim
  MP 'justinmk/vim-sneak'                  , { 'on': [] }
  MP 'easymotion/vim-easymotion'           , { 'on': [] }
  MP 'haya14busa/incsearch-easymotion.vim' , { 'on': [] }
  call timer_start(500, 'spacevim#defer#motion')
else
  MP 'justinmk/vim-sneak'
  MP 'easymotion/vim-easymotion'
  MP 'haya14busa/incsearch-easymotion.vim', { 'on': [
              \ '<Plug>(easymotion-prefix)',
              \ '<Plug>(easymotion-bd-f)',
              \ '<Plug>(easymotion-overwin-f)',
              \ '<Plug>(easymotion-overwin-f2)',
              \ '<Plug>(easymotion-bd-jk)',
              \ '<Plug>(easymotion-overwin-line)',
              \ '<Plug>(easymotion-bd-w)',
              \ '<Plug>(easymotion-overwin-w)',
              \ ] }
endif
