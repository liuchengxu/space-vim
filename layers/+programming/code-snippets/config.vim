scriptencoding utf-8

" ultisnips {
  " Set ultisnips triggers
  let g:UltiSnipsSnippetDirectories=['UltiSnips']
  exe 'set rtp+=' . expand(g:spacevim.base . '/private/UltiSnips')
  let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'

  " c-j c-k for moving in snippet
  let g:UltiSnipsJumpForwardTrigger = "<c-j>"
  let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

  if has_key(g:plugs, 'ncm2-ultisnips')
    " <CR> is used to expand snippets
    inoremap <silent> <expr> <CR> ((pumvisible() && empty(v:completed_item)) ?  "\<c-y>\<cr>" : (!empty(v:completed_item) ? ncm2_ultisnips#expand_or("", 'n') : "\<CR>" ))
    imap <expr> <c-u> ncm2_ultisnips#expand_or("\<Plug>(ultisnips_expand)", 'm')
    smap <c-u> <Plug>(ultisnips_expand)
    let g:UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
    let g:UltiSnipsRemoveSelectModeMappings = 0
  else
    let g:UltiSnipsExpandTrigger = '<C-e>'
  endif
" }
