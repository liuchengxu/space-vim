function! spacevim#test#term()
  call term_start(['ls'])
  setlocal nospell bufhidden=wipe nobuflisted nonumber
  setf test
  startinsert
endfunction

function! spacevim#test#layer()
  for [k, val] in items(g:topic2layers)
    echo val
  endfor
endfunction
