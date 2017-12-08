 nmap <buffer> <LocalLeader>b  :<C-U>call spacevim#lang#go#BuildGoFiles()<CR>
 nmap <buffer> <LocalLeader>r  <Plug>(go-run)
 nmap <buffer> <LocalLeader>t  <Plug>(go-test)

if !exists('g:spacevim_go_loaded')
 if g:spacevim_timer
   call timer_start(300, 'spacevim#defer#go')
 endif
 let g:spacevim_go_loaded = 1
endif
