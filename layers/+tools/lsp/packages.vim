if g:spacevim_lsp_engine ==# 'coc'
  MP 'neoclide/coc.nvim', { 'rev': 'release' }

  " Load these two plugins in core/ftplugin/vim.vim
  MP 'Shougo/neco-vim',   { 'lazy': 1 }
  MP 'neoclide/coc-neco', { 'lazy': 1 }
elseif g:spacevim_lsp_engine ==# 'vim_lsp'
  MP 'prabirshrestha/async.vim'
  MP 'prabirshrestha/vim-lsp'
  MP 'mattn/vim-lsp-settings'
  if spacevim#load('ale')
    MP 'rhysd/vim-lsp-ale'
  endif
elseif g:spacevim_lsp_engine ==# 'lcn'
  MP 'autozimu/LanguageClient-neovim', {
    \ 'rev': 'next',
    \ 'hook_post_update': function('spacevim#vim#plug#post_update',
    \   ['LanguageClient-neovim', 'bash install.sh']),
    \ }
endif
