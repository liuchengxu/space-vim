nnoremap <buffer> q :cclose<bar>:lclose<CR>
nnoremap <buffer> <CR> <CR>

if exists('*SetMyStatusline')
  call SetMyStatusline('')
endif
