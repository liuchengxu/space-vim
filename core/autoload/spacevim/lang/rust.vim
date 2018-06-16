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
