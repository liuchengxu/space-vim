augroup spacevimC
  autocmd!

  autocmd FileType c,cpp setlocal
              \ tabstop=2
              \ shiftwidth=2
              \ softtabstop=2

  autocmd FileType c,cpp setlocal cindent
  autocmd FileType c,cpp,objc nnoremap <LocalLeader>= :ClangFormat<CR>
  autocmd FileType c,cpp,objc vnoremap <LocalLeader>= :<C-u>ClangFormat<CR>

  if spacevim#LayerLoaded('programming')
    autocmd FileType c,cpp nnoremap <buffer> <LocalLeader>m :update<Bar>execute 'AsyncRun! make '.shellescape(@%, 1)<CR>
  else
    autocmd FileType c,cpp nnoremap <buffer> <LocalLeader>m :update<Bar>execute '! make '.shellescape(@%, 1)<CR>
  endif
augroup END

" vim-cpp-enhanced-highlight {
  let g:cpp_class_scope_highlight = 1
  let g:c_no_curly_error=1
" }
