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
  call plug#load('incsearch-easymotion.vim')
endfunction

function! spacevim#defer#unite(timer) abort
  call plug#load('unite.vim')
endfunction

function! spacevim#defer#markdown(timer) abort
  call plug#load('vim-markdown')
  call plug#load('vim-markdown-toc')
  call plug#load('markdown-preview.vim')
endfunction

function! spacevim#defer#fzf(timer) abort
  call plug#load('fzf')
  call plug#load('fzf.vim')
endfunction

function! spacevim#defer#rust(timer) abort
  call plug#load('rust.vim')
endfunction

function! spacevim#defer#go(defer) abort
   call plug#load('vim-go')
endfunction
