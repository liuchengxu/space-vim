augroup spacevimGo
  autocmd!
  autocmd FileType go nmap <LocalLeader>b  :<C-u>call spacevim#auto#BuildGoFiles()<CR>
  autocmd FileType go nmap <LocalLeader>r  <Plug>(go-run)
  autocmd FileType go nmap <LocalLeader>t  <Plug>(go-test)
augroup END

" vim-go {
  let g:go_highlight_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_build_constraints = 1
" }
