setlocal foldmethod=indent tabstop=4 textwidth=79

nnoremap <buffer> <F5>            :<C-U>call spacevim#lang#python#run()<CR>
nnoremap <buffer> <LocalLeader>=  :<C-U>call spacevim#lang#python#fmt()<CR>
nnoremap <buffer> <LocalLeader>cc :<C-U>call spacevim#lang#python#run()<CR>
nnoremap <buffer> <LocalLeader>cs :<C-U>call spacevim#lang#python#stop()<CR>
