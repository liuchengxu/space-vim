if get(g:, 'spacevim_lsp_prefer_coc', 0)
  MP 'neoclide/coc.nvim', { 'do': { -> coc#util#install()} }
  MP 'Shougo/neco-vim'
  MP 'neoclide/coc-neco'

  call timer_start(1000, function('spacevim#plug#coc#Init'))

else
  MP 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
endif
