if get(g:, 'which_key_use_floating_win', 1)
  finish
endif

setlocal laststatus=0 noshowmode noruler nonumber norelativenumber

augroup spacevimWhichKey
  autocmd!
  autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END
