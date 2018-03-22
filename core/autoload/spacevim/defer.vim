" 200
function! spacevim#defer#ale(timer) abort
  call plug#load('ale')
endfunction

" 250
function! spacevim#defer#airline(timer) abort
  call plug#load('vim-airline')
  call plug#load('vim-airline-themes')
  redraws!
endfunction

" 300
function! spacevim#defer#gitgutter(timer) abort
  call plug#load('vim-gitgutter')
  silent! GitGutterEnable
endfunction

" 400
function! spacevim#defer#programming(timer) abort
  call plug#load('rainbow')
  call plug#load('vim-rooter')
  call plug#load('vim-polyglot')
endfunction

" 500
function! spacevim#defer#defaults(timer) abort
  if has('patch-8.0.1206') || has('nvim-0.2.3')
    call plug#load('traces.vim')
  endif
  call plug#load('vim_current_word')
  call plug#load('vim-signature')
  call plug#load('vim-rsi')
endfunction

" 600
function! spacevim#defer#motion(timer) abort
  call plug#load('vim-sneak')
  call plug#load('vim-easymotion')
  call plug#load('incsearch-easymotion.vim')
endfunction

" 700
function! spacevim#defer#fzf(timer) abort
  call plug#load('fzf')
  call plug#load('fzf.vim')
endfunction

" 800
function! spacevim#defer#fugitive(timer) abort
  call plug#load('vim-fugitive')
endfunction

" 1000
function! spacevim#defer#ycm(timer) abort
  call plug#load('YouCompleteMe')
endfunction

function! spacevim#defer#unite(timer) abort
  call plug#load('unite.vim')
endfunction

function! spacevim#defer#markdown(timer) abort
  call plug#load('vim-markdown')
endfunction

function! spacevim#defer#rust(timer) abort
  call plug#load('rust.vim')
endfunction

function! spacevim#defer#go(timer) abort
   call plug#load('vim-go')
endfunction

function! spacevim#defer#python(timer) abort
  call plug#load('python-mode')
  call plug#load('SimpylFold')
endfunction
