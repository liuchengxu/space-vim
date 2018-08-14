if exists('b:did_spacevim_rs_ftplugin') || !spacevim#load('rust')
  finish
endif
let b:did_spacevim_rs_ftplugin = 1

nnoremap <silent> <buffer> <LocalLeader>r :<C-U>call spacevim#lang#rust#Run()<CR>
nnoremap <silent> <buffer> <LocalLeader>b :<C-U>call spacevim#lang#rust#Build()<CR>
nnoremap <silent> <buffer> <LocalLeader>= :<C-U>call spacevim#lang#rust#Fmt()<CR>

if g:spacevim.timer
  call timer_start(300, 'spacevim#defer#rust')
endif
