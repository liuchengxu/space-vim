let s:hidden_all = 0
function! spacevim#vim#toggle#HiddleAll()
  if s:hidden_all == 0
    let s:hidden_all = 1
    setlocal noshowmode noruler noshowcmd laststatus=0 cmdheight=1
  else
    let s:hidden_all = 0
    setlocal showmode ruler showcmd laststatus=2 cmdheight=1
  endif
endfunction

function! spacevim#vim#toggle#CursorColumn()
  if &cursorcolumn
    setlocal nocursorcolumn
  else
    setlocal cursorcolumn
  endif
endfunction

function! spacevim#vim#toggle#ColorColumn()
  if &colorcolumn
    setlocal colorcolumn=
  else
    setlocal colorcolumn=80
  endif
endfunction


