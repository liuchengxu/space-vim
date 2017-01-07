" if g:MAC
    " Plug 'ybian/smartim'
" endif

MP 'mhinz/vim-startify'

MP 'tpope/vim-surround'

MP 'Raimondi/delimitMate'

MP 'itchyny/vim-cursorword'

MP 'liuchengxu/space-vim-dark'

MP 'morhetz/gruvbox'

MP 'easymotion/vim-easymotion'
MP 'haya14busa/incsearch-easymotion.vim'

MP 'terryma/vim-multiple-cursors'

MP 'liuchengxu/vim-better-default'

MP 'danro/rename.vim',               { 'on' : 'Rename' }

MP 'ntpeters/vim-better-whitespace', { 'on': 'StripWhitespace' }

if !g:spacevim_nvim
    MP 'haya14busa/incsearch.vim',       { 'on': [
                \   '<Plug>(incsearch-forward)',
                \   '<Plug>(incsearch-backward)',
                \   '<Plug>(incsearch-stay)' ]
                \   }
    MP 'haya14busa/incsearch-fuzzy.vim',  { 'on': [
                \   '<Plug>(incsearch-fuzzy-/)',
                \   '<Plug>(incsearch-fuzzy-?)',
                \   '<Plug>(incsearch-fuzzy-stay)' ]
                \   }
endif

" Refer to https://github.com/junegunn/dotfiles  vimrc
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
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
