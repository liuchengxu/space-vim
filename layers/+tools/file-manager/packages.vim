MP 'danro/rename.vim',               { 'on' : 'Rename' }

" Refer to https://github.com/junegunn/dotfiles  vimrc
MP 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
augroup loadNerdtree
  autocmd!
  autocmd VimEnter * silent! autocmd! FileExplorer
  autocmd BufEnter,BufNew *
              \  if isdirectory(expand('<amatch>'))
              \|   call plug#load('nerdtree')
              \|   call nerdtree#checkForBrowse(expand("<amatch>"))
              \| endif
augroup END

MP 'Xuyuanp/nerdtree-git-plugin', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }

" Disable vim-nerdtree-syntax-highlight for the performance consideration, see #237
" MP 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
