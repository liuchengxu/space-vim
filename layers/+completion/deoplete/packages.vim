if g:spacevim_nvim
  MP 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
  MP 'eagletmt/neco-ghc'
else
  MP 'Shougo/deoplete.nvim'
  MP 'roxma/nvim-yarp'
  MP 'roxma/vim-hug-neovim-rpc'
endif
