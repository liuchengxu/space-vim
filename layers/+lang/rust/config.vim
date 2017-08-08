augroup spacevimRust
  autocmd BufEnter *.rs nnoremap <LocalLeader>r :call spacevim#lang#rust#Run()<CR>
  autocmd BufEnter *.rs nnoremap <LocalLeader>b :call spacevim#lang#rust#Build()<CR>
augroup END

