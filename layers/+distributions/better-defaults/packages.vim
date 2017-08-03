" if g:MAC
    " Plug 'ybian/smartim'
" endif

MP 'tpope/vim-rsi'

MP 't9md/vim-choosewin'

MP 'mhinz/vim-startify', { 'on': 'Startify' }
augroup spacevimStart
  autocmd!
  autocmd VimEnter *
              \   if !argc()
              \|    call plug#load('vim-startify')
              \|    silent! Startify
              \|  endif
augroup END

MP 'dominikduda/vim_current_word'

" Bug here.
" MP 'kana/vim-operator-user',         { 'on': '<Plug>(operator-flashy)' }
" MP 'haya14busa/vim-operator-flashy', { 'on': '<Plug>(operator-flashy)' }

MP 'ntpeters/vim-better-whitespace', { 'on': 'StripWhitespace' }

if !g:spacevim_nvim
  MP 'haya14busa/incsearch.vim',       { 'on': [
              \ '<Plug>(incsearch-forward)',
              \ '<Plug>(incsearch-backward)',
              \ '<Plug>(incsearch-stay)' ]
              \ }
  MP 'haya14busa/incsearch-fuzzy.vim',  { 'on': [
              \ '<Plug>(incsearch-fuzzy-/)',
              \ '<Plug>(incsearch-fuzzy-?)',
              \ '<Plug>(incsearch-fuzzy-stay)' ]
              \ }
endif
