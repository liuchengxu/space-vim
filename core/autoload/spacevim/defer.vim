function! spacevim#defer#ale(timer) abort
  call plug#load('ale')
endfunction

function! spacevim#defer#airline(timer) abort
  call plug#load('vim-airline')
  call plug#load('vim-airline-themes')
  redraws!
endfunction

function! spacevim#defer#git(timer) abort
  call plug#load('vim-fugitive')
  call plug#load('vim-gitgutter')
  GitGutterEnable
endfunction

function! spacevim#defer#defaults(timer) abort
  call plug#load('vim-signature')
  call plug#load('vim-rsi')
  call plug#load('vim_current_word')

  if has('patch-8.0.1206') || has('nvim-0.2.3')
    call plug#load('traces.vim')
  endif
endfunction

function! spacevim#defer#programming(timer) abort
  call plug#load('rainbow')
  call plug#load('vim-polyglot')
  call plug#load('vim-rooter')
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
endfunction

function! spacevim#defer#fzf(timer) abort
  call plug#load('fzf')
  call plug#load('fzf.vim')
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

function! spacevim#defer#ycm(timer) abort
  call plug#load('YouCompleteMe')
endfunction
