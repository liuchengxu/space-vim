if spacevim#load('tmux')
  MP 'ctrlpvim/ctrlp.vim'
  MP 'FelikZ/ctrlp-py-matcher'
else
  MP 'ctrlpvim/ctrlp.vim',      { 'on_cmd': ['CtrlP', 'CtrlPMRU'],
    \ 'hook_post_source': 'call dein#source(\"ctrlp-py-matcher\")' }
  MP 'FelikZ/ctrlp-py-matcher', { 'lazy': 1 }
endif
