MP 'danro/rename.vim',               { 'on' : 'Rename' }

" Refer to https://github.com/junegunn/dotfiles  vimrc
MP 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
augroup nerd_loader
    autocmd!
    autocmd VimEnter * silent! autocmd! FileExplorer
    autocmd BufEnter,BufNew *
                \  if isdirectory(expand('<amatch>'))
                \|   call plug#load('nerdtree')
                \|   execute 'autocmd! nerd_loader'
                \| endif
augroup END

MP 'Xuyuanp/nerdtree-git-plugin',             { 'on': 'NERDTreeToggle' }
MP 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }
