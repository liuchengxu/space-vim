function! spacevim#defer#ale(timer) abort
  call plug#load('ale')
endfunction

function! spacevim#defer#git(timer) abort
  call plug#load('vim-fugitive')
  call plug#load('vim-gitgutter')
  GitGutterEnable
endfunction

function! spacevim#defer#signature(timer) abort
  call plug#load('vim-signature')
endfunction

function! spacevim#defer#motion(timer) abort
  call plug#load('vim-sneak')
  call plug#load('vim-easymotion')
endfunction

function! spacevim#defer#unite(timer) abort
  call plug#load('unite.vim')
endfunction
