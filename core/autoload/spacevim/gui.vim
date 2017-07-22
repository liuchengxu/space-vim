let s:lines=&lines
let s:columns=&columns

function! s:enter_full_screen()
  setlocal lines=999 columns=999
  setlocal fullscreen
endfunction

function! s:leave_full_screen()
  let &lines=s:lines
  let &columns=s:columns
  setlocal nofullscreen
endfunction

function! spacevim#gui#ToggleFullScreen()
  if &fullscreen
    call s:leave_full_screen()
  else
    call s:enter_full_screen()
  endif
endfunction
