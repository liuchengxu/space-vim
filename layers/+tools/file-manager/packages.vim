MP 'danro/rename.vim',               { 'on' : 'Rename' }

" Refer to https://github.com/junegunn/dotfiles  vimrc
MP 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
autocmd! User nerdtree call spacevim#autocmd#nerdtree#Init() | if exists('*UserConfig') | call UserConfig() | endif
augroup loadNerdtree
  autocmd!
  autocmd VimEnter * silent! autocmd! FileExplorer
  autocmd BufEnter,BufNew *
              \  if isdirectory(expand('<amatch>'))
              \|   call plug#load('nerdtree')
              \|   call nerdtree#checkForBrowse(expand("<amatch>"))
              \| endif
augroup END

if get(g:, 'spacevim_nerd_fonts', 0)
  MP 'ryanoasis/vim-devicons'
endif

MP 'liuchengxu/nerdtree-dash'
MP 'Xuyuanp/nerdtree-git-plugin', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }

" Disable vim-nerdtree-syntax-highlight for the performance consideration, see #237
" MP 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
