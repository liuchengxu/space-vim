" if g:spacevim.os.mac
    " Plug 'ybian/smartim'
" endif

MP 'kshenoy/vim-signature', { 'lazy': g:spacevim.speed_up_via_timer }
MP 'tpope/vim-rsi', { 'lazy': g:spacevim.speed_up_via_timer }
MP 'dominikduda/vim_current_word', { 'lazy': g:spacevim.speed_up_via_timer }
if has('patch-8.0.1206') || has('nvim-0.2.3')
  MP 'markonm/traces.vim', { 'lazy': g:spacevim.speed_up_via_timer }
endif

MP 't9md/vim-choosewin', { 'on_map': '<Plug>(choosewin)' }
if get(g:, 'spacevim_enable_startify', 1)
  MP 'mhinz/vim-startify', { 'on_cmd': 'Startify',
    \ 'hook_source': function('spacevim#autocmd#startify#Init') }
endif

" Bug here.
" MP 'kana/vim-operator-user',         { 'on_map': '<Plug>(operator-flashy)' }
" MP 'haya14busa/vim-operator-flashy', { 'on_map': '<Plug>(operator-flashy)' }

MP 'ntpeters/vim-better-whitespace', { 'on_cmd': 'StripWhitespace' }

if has('patch-8.0.1238')
  MP 'haya14busa/is.vim'
  MP 'osyo-manga/vim-anzu', { 'on_map': ['<Plug>(anzu-n-with-echo)', '<Plug>(anzu-N-with-echo)'] }
else
  MP 'google/vim-searchindex'
  if !g:spacevim.nvim
    MP 'haya14busa/incsearch.vim',       { 'on_map': [
                \ '<Plug>(incsearch-forward)',
                \ '<Plug>(incsearch-backward)',
                \ '<Plug>(incsearch-stay)' ]
                \ }
    MP 'haya14busa/incsearch-fuzzy.vim',  { 'on_map': [
                \ '<Plug>(incsearch-fuzzyspell-/)',
                \ '<Plug>(incsearch-fuzzyspell-?)',
                \ '<Plug>(incsearch-fuzzyspell-stay)' ]
                \ }
  endif
endif
