" Refer to https://github.com/junegunn/vim-plug/wiki/faq
" Load on nothing
MP 'SirVer/ultisnips', { 'on': [] }
MP 'honza/vim-snippets', { 'on': [] }

augroup loadSnips
  autocmd!
  autocmd InsertEnter * call plug#load('ultisnips', 'vim-snippets')
              \| autocmd! loadSnips
augroup END
