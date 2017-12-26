MP 'artur-shaik/vim-javacomplete2',  { 'on': [] }

" Load vim-javacomplete2 for java
function! s:invoke_javacomplete()
  if &filetype ==# 'java'
    call plug#load('vim-javacomplete2')
  endif
endfunction

augroup loadJava
  autocmd!
  autocmd InsertEnter * call s:invoke_javacomplete()
augroup END
