MP 'artur-shaik/vim-javacomplete2',  { 'on': [] }

MP 'airblade/vim-rooter', { 'for': 'java' }

" Load vim-javacomplete2 for java
function! s:invoke_javacomplete()
    if &filetype ==# 'java'
        call plug#load('vim-javacomplete2')
        inoremap <expr> <Tab> pumvisible() ? "\<C-N>" : "\<Tab>"
    endif
endfunction

augroup LOAD_JAVA
    autocmd!
    autocmd InsertEnter * call s:invoke_javacomplete()
augroup END
