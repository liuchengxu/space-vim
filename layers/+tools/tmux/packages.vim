MP 'christoomey/vim-tmux-navigator'
if g:spacevim_tmux
  if spacevim#LayerLoaded('unite')
    MP 'lucidstack/ctrlp-tmux.vim',{'on': 'CtrlPTmux'}
  endif
  MP 'jebaum/vim-tmuxify'
endif
