if exists('b:did_spacevim_rs_ftplugin') || !spacevim#load('rust')
  finish
endif
let b:did_spacevim_rs_ftplugin = 1

nnoremap <buffer> <LocalLeader>r :<C-U>call spacevim#lang#rust#Run()<CR>
nnoremap <buffer> <LocalLeader>b :<C-U>call spacevim#lang#rust#Build()<CR>
nnoremap <buffer> <LocalLeader>= :RustFmt<CR>

if spacevim#load('ycmd')
  nnoremap <buffer> gd :YcmComplter GoTo<CR>
endif

if g:spacevim.timer
  call timer_start(300, 'spacevim#defer#rust')
endif
