scriptencoding utf-8

" vim-fugitive {
  nnoremap <silent> <Leader>gs :Git<CR>
  nnoremap <silent> <Leader>gd :Gdiffsplit<CR>
  nnoremap <silent> <Leader>gc :Git commit<CR>
  nnoremap <silent> <Leader>gb :Git blame<CR>
  nnoremap <silent> <Leader>gl :Gclog<CR>
  nnoremap <silent> <Leader>gp :Git push<CR>
  nnoremap <silent> <Leader>gr :Gread<CR>
  nnoremap <silent> <Leader>gw :Gwrite<CR>
  nnoremap <silent> <Leader>ge :Gedit<CR>
  " Mnemonic _i_nteractive
  nnoremap <silent> <Leader>gi :Git add -p %<CR>
  nnoremap <silent> <Leader>gg :call spacevim#plug#toggle#Git()<CR>
"}

" vim-gitgutter {
  " consistent with airline
  " let g:gitgutter_sign_added = '+'
  " let g:gitgutter_sign_modified = '~'
  " let g:gitgutter_sign_removed = '-'
  " let g:gitgutter_sign_removed_first_line = '^^'
  " let g:gitgutter_sign_modified_removed = 'ww'
  " let g:gitgutter_override_sign_column_highlight = 0
" }

" vim-signify {
  let g:signify_sign_delete            = '-'
  let g:signify_sign_delete_first_line = '^'
  let g:signify_sign_change            = '~'
" }

  nnoremap <silent> <Leader>tg :call spacevim#plug#toggle#Git()<CR>
