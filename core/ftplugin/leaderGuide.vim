if !spacevim#load('which-key')
  finish
endif
setlocal laststatus=0 noshowmode noruler
augroup spacevimLeaderGuide
  autocmd!
  autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END
