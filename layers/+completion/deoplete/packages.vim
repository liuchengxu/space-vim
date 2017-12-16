if g:spacevim_nvim
  MP 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
  MP 'eagletmt/neco-ghc'
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
