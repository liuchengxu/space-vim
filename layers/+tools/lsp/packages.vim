if get(g:, 'spacevim_lsp_prefer_coc', 0)
  MP 'neoclide/coc.nvim', { 'do': { -> coc#util#install()} }

  call timer_start(1000, function('spacevim#plug#coc#Init'))

  " Load these two plugins in core/ftplugin/vim.vim
  MP 'Shougo/neco-vim',   { 'on': [] }
  MP 'neoclide/coc-neco', { 'on': [] }

else
  MP 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
endif
