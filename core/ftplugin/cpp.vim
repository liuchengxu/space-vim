if exists('b:did_spacevim_cpp_ftplugin') || !spacevim#load('c-c++')
  finish
endif
let b:did_spacevim_cpp_ftplugin = 1

setlocal cindent tabstop=2 shiftwidth=2 softtabstop=2

let b:ale_linters = ['clang']

nnoremap <buffer> <LocalLeader>= :ClangFormat<CR>
vnoremap <buffer> <LocalLeader>= :<C-U>ClangFormat<CR>
