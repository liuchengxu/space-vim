MP 'junegunn/gv.vim', { 'on': ['GV', 'GV!'] }

if g:spacevim.timer
  MP 'tpope/vim-fugitive'     , { 'on': [] }
  MP 'airblade/vim-gitgutter' , { 'on': [] }
  call timer_start(300, 'spacevim#defer#gitgutter')
  call timer_start(800, 'spacevim#defer#fugitive')
else
  MP 'tpope/vim-fugitive'
  MP 'airblade/vim-gitgutter'
endif
