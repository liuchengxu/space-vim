if get(g:, 'spacevim_lsp_prefer_coc', 0)
  MP 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
else
  MP 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
endif
