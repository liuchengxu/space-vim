if exists('b:did_spacevim_py_ftplugin') || !spacevim#load('python')
  finish
endif
let b:did_spacevim_py_ftplugin = 1

setlocal foldmethod=indent tabstop=4 textwidth=79

if g:spacevim.timer
  call timer_start(300, 'spacevim#defer#python')
endif

let b:ale_linters = ['flake8']
let b:ale_fixers = [
\   'remove_trailing_lines',
\   'isort',
\   'yapf',
\]

function! s:fmt()
  if exists(':ALEFix')
    ALEFix
  else
    call spacevim#lang#python#fmt()
  endif
endfunction

nnoremap <buffer> <silent> <LocalLeader>=  :<C-U>call <SID>fmt()<CR>

nnoremap <buffer> <F5>            :<C-U>call spacevim#lang#python#run()<CR>
nnoremap <buffer> <LocalLeader>cc :<C-U>call spacevim#lang#python#run()<CR>
nnoremap <buffer> <LocalLeader>cs :<C-U>call spacevim#lang#python#stop()<CR>
