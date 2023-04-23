MP 'christoomey/vim-tmux-navigator'
if g:spacevim.tmux
  if spacevim#load('unite')
    MP 'lucidstack/ctrlp-tmux.vim',{'on_cmd': 'CtrlPTmux'}
  endif
  MP 'jebaum/vim-tmuxify'
endif
