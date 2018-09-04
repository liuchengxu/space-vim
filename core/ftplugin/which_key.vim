setlocal laststatus=0 noshowmode noruler nonumber norelativenumber

augroup spacevimWhichKey
  autocmd!
  autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END
