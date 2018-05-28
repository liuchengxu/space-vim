if g:spacevim.gui && !has('terminal')
  MP 'Yggdroot/LeaderF'
else
  if g:spacevim.timer
    MP 'junegunn/fzf',  { 'dir': '~/.fzf', 'do': './install --all', 'on': [] }
    MP 'junegunn/fzf.vim', { 'on': [] }
    call timer_start(700, 'spacevim#defer#fzf')
  else
    MP 'junegunn/fzf',  { 'dir': '~/.fzf', 'do': './install --all' }
    MP 'junegunn/fzf.vim'
  endif
endif
