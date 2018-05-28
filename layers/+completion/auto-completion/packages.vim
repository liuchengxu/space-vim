if g:spacevim.nvim
  MP 'roxma/nvim-completion-manager'
  MP 'roxma/nvim-cm-racer'
  MP 'roxma/ncm-clang'
  MP 'Shougo/neco-vim'
  MP 'roxma/ncm-github'
  MP 'fgrsnau/ncm-otherbuf'
  MP 'roxma/nvim-cm-tern',  {'do': 'npm install'}
elseif g:spacevim.vim8
  MP 'maralla/completor.vim'
  MP 'maralla/completor-neosnippet'
else
  MP 'lifepillar/vim-mucomplete'
endif
