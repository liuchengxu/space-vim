if exists('b:did_spacevim_go_ftplugin') || !spacevim#load('go')
  finish
endif
let b:did_spacevim_go_ftplugin = 1

let b:ale_linters = ['golint']

nmap <buffer> <LocalLeader>b  :<C-U>call spacevim#lang#go#BuildGoFiles()<CR>
nmap <buffer> <LocalLeader>r  <Plug>(go-run)
nmap <buffer> <LocalLeader>t  <Plug>(go-test)
nmap <buffer> <LocalLeader>i  :GoImports<CR>
nmap <buffer> gi <Plug>(go-implements)

if g:spacevim.timer
 call timer_start(300, 'spacevim#defer#go')
endif
