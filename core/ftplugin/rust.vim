if exists('b:did_spacevim_rs_ftplugin') || !spacevim#load('rust')
  finish
endif
let b:did_spacevim_rs_ftplugin = 1

nnoremap <silent> <buffer> <LocalLeader>r :<C-U>call spacevim#lang#rust#Run()<CR>
nnoremap <silent> <buffer> <LocalLeader>b :<C-U>call spacevim#lang#rust#Build()<CR>
nnoremap <buffer> <silent> <LocalLeader>= :<C-U>call spacevim#lang#util#Format()<CR>

" RustTestT runs `cargo test` in current working directory
" RustTestT! runs `cargo test` in the directory of current file.
command! -bang -buffer -nargs=* RustTestT call spacevim#lang#rust#Test(<bang>0, <f-args>)

let b:ale_fixers = [
      \ 'remove_trailing_lines',
      \ 'rustfmt',
      \ ]

if g:spacevim.timer
  call timer_start(300, 'spacevim#defer#rust')
endif
