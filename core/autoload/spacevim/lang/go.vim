" run :GoBuild or :GoTestCompile based on the go file, refer to
" vim-go-tutorial
function! spacevim#lang#go#BuildGoFiles()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
