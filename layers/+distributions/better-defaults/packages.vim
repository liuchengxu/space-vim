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

if has('patch-8.0.1238')
  MP 'haya14busa/is.vim'
  MP 'osyo-manga/vim-anzu', { 'on': ['<Plug>(anzu-n-with-echo)', '<Plug>(anzu-N-with-echo)'] }
else
  MP 'google/vim-searchindex'
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
endif

if g:spacevim_vim8 || g:spacevim_nvim
  MP 'kshenoy/vim-signature', { 'on': [] }
  call timer_start(500, 'spacevim#defer#signature')
else
  MP 'kshenoy/vim-signature'
endif
