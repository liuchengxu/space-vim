if g:spacevim.nvim
  MP 'Shougo/deoplete.nvim', { 'hook_post_update': ':UpdateRemotePlugins' }
else
  MP 'Shougo/deoplete.nvim'
  MP 'roxma/nvim-yarp'
  MP 'roxma/vim-hug-neovim-rpc'
endif

" Completion sources
MP 'eagletmt/neco-ghc'
MP 'Shougo/neco-vim'
MP 'sebastianmarkow/deoplete-rust'
MP 'zchee/deoplete-go', { 'hook_post_update':
  \ function('spacevim#vim#plug#post_update', ['deoplete-go', 'make']) }
