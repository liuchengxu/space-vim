" temporarily disabled
" MP 'Shougo/denite.nvim'

MP 'Shougo/unite.vim'

if core_config#LayerLoaded('tmux')
   MP 'ctrlpvim/ctrlp.vim'
   MP 'FelikZ/ctrlp-py-matcher'
else
   MP 'ctrlpvim/ctrlp.vim',      { 'on': ['CtrlP', 'CtrlPMRU'] }
   MP 'FelikZ/ctrlp-py-matcher', { 'on': ['CtrlP', 'CtrlPMRU'] }
endif
