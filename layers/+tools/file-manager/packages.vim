MP 'danro/rename.vim',               { 'on' : 'Rename' }

if exists('g:coc_global_extensions') && index(g:coc_global_extensions, 'coc-explorer') > -1
  " coc.nvim will handle this automatically.
else
  " Refer to https://github.com/junegunn/dotfiles  vimrc
  MP 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
  autocmd! User nerdtree call spacevim#autocmd#nerdtree#Init()
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
endif
