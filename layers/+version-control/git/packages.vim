MP 'junegunn/gv.vim', { 'on': ['GV', 'GV!'] }

if g:spacevim_timer
  MP 'tpope/vim-fugitive'     , { 'on': [] }
  MP 'airblade/vim-gitgutter' , { 'on': [] }
  call timer_start(300, 'spacevim#defer#git')
else
  MP 'tpope/vim-fugitive'
  MP 'airblade/vim-gitgutter'
endif
