if g:spacevim_gui
  MP 'Yggdroot/LeaderF'
else
  MP 'junegunn/fzf',  { 'dir': '~/.fzf', 'do': './install --all' } | MP 'junegunn/fzf.vim'
  MP 'tweekmonster/fzf-filemru', { 'on': 'ProjectMru' }
endif
