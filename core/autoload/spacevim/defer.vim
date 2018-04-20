function! s:lod(...)
  " Ignore unknown plugins from vim-plug due to the excluded plugins
  silent! call plug#load(a:000)
endfunction

" 200
function! spacevim#defer#ale(timer) abort
  call s:lod('ale')
endfunction

" 250
function! spacevim#defer#airline(timer) abort
  call s:lod('vim-airline', 'vim-airline-themes')
  redraws!
endfunction

" 300
function! spacevim#defer#gitgutter(timer) abort
  call s:lod('vim-gitgutter')
  silent! GitGutterEnable
endfunction

" 400
function! spacevim#defer#programming(timer) abort
  call s:lod('rainbow', 'vim-rooter', 'vim-polyglot')
endfunction

" 500
function! spacevim#defer#defaults(timer) abort
  if has('patch-8.0.1206') || has('nvim-0.2.3')
    call s:lod('traces.vim')
  endif
  call s:lod('vim_current_word', 'vim-signature', 'vim-rsi')
endfunction

" 600
function! spacevim#defer#motion(timer) abort
  call s:lod('vim-sneak', 'vim-easymotion', 'incsearch-easymotion.vim')
endfunction

" 700
function! spacevim#defer#fzf(timer) abort
  call s:lod('fzf', 'fzf.vim')
endfunction

" 800
function! spacevim#defer#fugitive(timer) abort
  call s:lod('vim-fugitive')
endfunction

" 1000
function! spacevim#defer#ycm(timer) abort
  call s:lod('YouCompleteMe')
endfunction

function! spacevim#defer#unite(timer) abort
  call s:lod('unite.vim')
endfunction

function! spacevim#defer#markdown(timer) abort
  call s:lod('vim-markdown')
endfunction

function! spacevim#defer#rust(timer) abort
  call s:lod('rust.vim')
endfunction

function! spacevim#defer#go(timer) abort
   call s:lod('vim-go')
endfunction

function! spacevim#defer#python(timer) abort
  call s:lod('python-mode', 'SimpylFold')
endfunction
