scriptencoding utf-8

if has_key(g:plugs, 'vim-mucomplete')
  let g:mucomplete#enable_auto_at_startup = 1
  set completeopt+=noselect
  inoremap <expr> <c-e> mucomplete#popup_exit("\<c-e>")
  inoremap <expr> <c-y> mucomplete#popup_exit("\<c-y>")
  inoremap <expr>  <cr> mucomplete#popup_exit("\<cr>")

  " Fix key mappings' clash from vim-better-default
  iunmap <c-j>
  iunmap <c-h>
endif

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "<C-R>=spacevim#util#ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"
