MP 'junegunn/gv.vim', { 'on': ['GV', 'GV!'] }

if g:spacevim_vim8 || g:spacevim_nvim
  MP 'tpope/vim-fugitive'     , { 'on': [] }
  MP 'airblade/vim-gitgutter' , { 'on': [] }
  call timer_start(500, 'spacevim#defer#git')
else
  MP 'tpope/vim-fugitive'
  MP 'airblade/vim-gitgutter'
endif
