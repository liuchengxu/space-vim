function! spacevim#util#ToggleCursorColumn()
  if &cursorcolumn
    set nocursorcolumn
  else
    set cursorcolumn
  endif
endfunction

let s:lines=&lines
let s:columns=&columns
function! s:enter_full_screen()
  set lines=999 columns=999
  set fullscreen
endfunction

function! s:leave_full_screen()
  let &lines=s:lines
  let &columns=s:columns
  set nofullscreen
endfunction

function! spacevim#util#ToggleFullScreen()
  if &fullscreen
    call s:leave_full_screen()
  else
    call s:enter_full_screen()
  endif
endfunction
