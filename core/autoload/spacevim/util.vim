function! spacevim#util#ToggleCursorColumn()
  if &cursorcolumn
    setlocal nocursorcolumn
  else
    setlocal cursorcolumn
  endif
endfunction

function! spacevim#util#ToggleColorColumn()
  if &colorcolumn
    setlocal colorcolumn=
  else
    setlocal colorcolumn=80
  endif
endfunction

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

function! spacevim#util#ToggleFullScreen()
  if &fullscreen
    call s:leave_full_screen()
  else
    call s:enter_full_screen()
  endif
endfunction

function! spacevim#util#CompileAndRun()
  exec 'w'
  if &filetype == 'c'
    exec "AsyncRun! gcc % -o %<; time ./%<"
  elseif &filetype == 'rust'
    exec "AsyncRun! rustc % -o %<; time ./%<"
  elseif &filetype == 'cpp'
    exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
  elseif &filetype == 'java'
    exec "AsyncRun! javac %; time java %<"
  elseif &filetype == 'sh'
    exec "AsyncRun! time bash %"
  elseif &filetype == 'python'
    exec "AsyncRun! time python %"
  elseif &filetype == 'ruby'
    exec "AsyncRun! time ruby %"
  endif
endfunction

