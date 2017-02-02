" if g:MAC
    " Plug 'ybian/smartim'
" endif

MP 'tpope/vim-rsi'

MP 'mhinz/vim-startify'

MP 'tpope/vim-surround'

MP 'itchyny/vim-cursorword'

MP 'terryma/vim-multiple-cursors'

" MP 'easymotion/vim-easymotion',           { 'on': [
            " \   '<Plug>(easymotion-prefix)',
            " \   '<Plug>(easymotion-bd-f)',
            " \   '<Plug>(easymotion-overwin-f)',
            " \   '<Plug>(easymotion-overwin-f2)',
            " \   '<Plug>(easymotion-bd-jk)',
            " \   '<Plug>(easymotion-overwin-line)',
            " \   '<Plug>(easymotion-bd-w)',
            " \   '<Plug>(easymotion-overwin-w)',
            " \   ] }

MP 'easymotion/vim-easymotion'

MP 'haya14busa/incsearch-easymotion.vim', { 'on': [
            \   '<Plug>(easymotion-prefix)',
            \   '<Plug>(easymotion-bd-f)',
            \   '<Plug>(easymotion-overwin-f)',
            \   '<Plug>(easymotion-overwin-f2)',
            \   '<Plug>(easymotion-bd-jk)',
            \   '<Plug>(easymotion-overwin-line)',
            \   '<Plug>(easymotion-bd-w)',
            \   '<Plug>(easymotion-overwin-w)',
            \   ] }

" Bug here.
" MP 'kana/vim-operator-user',         { 'on': '<Plug>(operator-flashy)' }
" MP 'haya14busa/vim-operator-flashy', { 'on': '<Plug>(operator-flashy)' }

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
