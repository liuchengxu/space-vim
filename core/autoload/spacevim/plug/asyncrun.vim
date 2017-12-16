function! spacevim#plug#asyncrun#CompileAndRun()
  let l:cmd = {
        \ 'c'      : "gcc % -o %<; time ./%<",
        \ 'sh'     : "time bash %",
        \ 'go'     : "go run %",
        \ 'cpp'    : "g++ -std=c++11 % -o %<; time ./%<",
        \ 'ruby'   : "time ruby %",
        \ 'java'   : "javac %; time java %<",
        \ 'rust'   : "rustc % -o %<; time ./%<",
        \ 'python' : "time python %",
        \ 'haskell': "ghc % -o %< && ./%<",
        \}
  let l:ft = &filetype
  if has_key(l:cmd, l:ft)
    exec 'w'
    exec "AsyncRun! ".l:cmd[l:ft]
  else
    call spacevim#util#err("spacevim#util#CompileAndRun not supported in current filetype!")
  endif
endfunction


