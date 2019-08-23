if g:spacevim.gui && !has('terminal')
  MP 'Yggdroot/LeaderF'
else
  if g:spacevim.speed_up_via_timer
    if get(g:, 'spacevim_prefer_skim', 0)
      MP 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
      MP 'lotabout/skim.vim'
    else
      MP 'junegunn/fzf',  { 'dir': '~/.fzf', 'do': './install --all', 'on': [] }
      MP 'junegunn/fzf.vim', { 'on': [] }
      call timer_start(700, 'spacevim#defer#fzf')
    endif
  else
    if get(g:, 'spacevim_prefer_skim', 0)
      MP 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
      MP 'lotabout/skim.vim'
    else
      MP 'junegunn/fzf',  { 'dir': '~/.fzf', 'do': './install --all' }
      MP 'junegunn/fzf.vim'
    endif
  endif
endif
