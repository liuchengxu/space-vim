scriptencoding utf-8

if has_key(g:plugs, 'vim-mucomplete')
  let g:mucomplete#enable_auto_at_startup = 1
  let g:mucomplete#no_mappings = 1
  inoremap <expr> <c-e> mucomplete#popup_exit("\<c-e>")
  inoremap <expr> <c-y> mucomplete#popup_exit("\<c-y>")
  inoremap <expr>  <cr> mucomplete#popup_exit("\<cr>")

  " Fix key mappings' clash from vim-better-default
  iunmap <c-j>
  iunmap <c-h>
endif

" :h completeopt
set completeopt=noinsert,menuone,noselect

inoremap <expr> <Tab> spacevim#vim#complete#Tab()
inoremap <expr> <S-Tab> spacevim#vim#complete#STab()
inoremap <expr> <CR> spacevim#vim#complete#CR()
