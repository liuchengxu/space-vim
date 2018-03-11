let g:spacevim#lang#rust#tagbar_type = {
      \ 'ctagstype' : 'rust',
      \ 'kinds' : [
        \'T:types,type definitions',
        \'f:functions,function definitions',
        \'g:enum,enumeration names',
        \'s:structure names',
        \'m:modules,module names',
        \'c:consts,static constants',
        \'t:traits',
        \'i:impls,trait implementations',
        \]
      \}
function! spacevim#lang#rust#Run()
  if has_key(g:plugs, 'asyncrun.vim')
    AsyncRun cargo run
  else
    exec ':!cargo run<CR>'
  endif
endfunction

function! spacevim#lang#rust#Build()
  if has_key(g:plugs, 'asyncrun.vim')
    AsyncRun cargo build
  else
    exec ':!cargo build<CR>'
  endif
endfunction
