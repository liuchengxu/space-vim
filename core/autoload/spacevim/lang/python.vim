function! spacevim#lang#python#run()
  execute 'AsyncRun! python '.shellescape(@%, 1)<CR>
  execute 'AsyncRun! python '.shellescape(@%, 1)<CR>
  execute 'AsyncStop!'<CR>
endfunction

function! spacevim#lang#python#fmt()
  if executable('yapf')
    " Code formatter
    :0,$!yapf<CR>
  else
    call spacevim#util#err('yapf is unavailable, please install it first.')<CR>
  endif
endfunction

