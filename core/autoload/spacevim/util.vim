function! spacevim#util#err(msg)
  echohl ErrorMsg
  echom '[space-vim] '.a:msg
  echohl None
endfunction

function! spacevim#util#warn(cmd, msg)
  echohl WarningMsg
  echom '[space-vim] '.a:msg
  echohl None
endfunction

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

function! spacevim#util#CompileAndRun()
  exec 'w'
  if &filetype == 'c'
    let l:cmd = "gcc % -o %<; time ./%<"
  elseif &filetype == 'cpp'
    let l:cmd = "g++ -std=c++11 % -o %<; time ./%<"
  elseif &filetype == 'go'
    let l:cmd = "go run %"
  elseif &filetype == 'java'
    let l:cmd = "javac %; time java %<"
  elseif &filetype == 'python'
    let l:cmd = "time python %"
  elseif &filetype == 'ruby'
    let l:cmd = "time ruby %"
  elseif &filetype == 'rust'
    let l:cmd = "rustc % -o %<; time ./%<"
  elseif &filetype == 'sh'
    let l:cmd = "time bash %"
  endif
  exec "AsyncRun! ".l:cmd
endfunction

function! spacevim#util#Runtimepath()
  for path in split(&runtimepath, ',')
    echo path
  endfor
endfunction

" http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
function! spacevim#util#SyntaxHiGroup()
  echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
  \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
  \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
endfunction
