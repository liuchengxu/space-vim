if !spacevim#load('fzf')
  finish
endif
setl laststatus=0 noshowmode noruler
augroup spacevimFZF
  autocmd!
  autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END
