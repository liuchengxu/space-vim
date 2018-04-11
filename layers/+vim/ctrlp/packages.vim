if spacevim#load('tmux')
  MP 'ctrlpvim/ctrlp.vim'
  MP 'FelikZ/ctrlp-py-matcher'
else
  MP 'ctrlpvim/ctrlp.vim',      { 'on': ['CtrlP', 'CtrlPMRU'] }
  MP 'FelikZ/ctrlp-py-matcher', { 'on': ['CtrlP', 'CtrlPMRU'] }
endif
