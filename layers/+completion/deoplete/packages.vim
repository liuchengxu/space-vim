if g:spacevim.nvim
  MP 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
else
  MP 'Shougo/deoplete.nvim'
  MP 'roxma/nvim-yarp'
  MP 'roxma/vim-hug-neovim-rpc'
endif

" Completion sources
MP 'eagletmt/neco-ghc'
MP 'Shougo/neco-vim'
MP 'sebastianmarkow/deoplete-rust'
MP 'zchee/deoplete-go', { 'do': 'make' }
