" if g:MAC
    " Plug 'ybian/smartim'
" endif

MP 'tpope/vim-rsi'

MP 'mhinz/vim-startify'

MP 'tpope/vim-surround'

MP 'itchyny/vim-cursorword'

MP 'terryma/vim-multiple-cursors'

" Bug here.
" MP 'kana/vim-operator-user',         { 'on': '<Plug>(operator-flashy)' }
" MP 'haya14busa/vim-operator-flashy', { 'on': '<Plug>(operator-flashy)' }

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
