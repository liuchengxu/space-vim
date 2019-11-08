MP 'tpope/vim-surround'
MP 'pelodelfuego/vim-swoop'
MP 'terryma/vim-multiple-cursors'

MP 'scrooloose/nerdcommenter',        { 'on': '<Plug>NERDCommenterToggle' }

" auto-pairs may interfere with vim-clap. You can disable auto-pairs and use
" the other alternatives, e.g., coc-pairs.
MP 'jiangmiao/auto-pairs', { 'on': [] }

function! s:TryInitAutoPairs() abort
  if !has_key(g:plugs, 'auto-pairs')
    return
  endif
  if !exists('g:AutoPairsLoaded')
    call plug#load('auto-pairs')
  endif
  if exists('*AutoPairsTryInit')
    call AutoPairsTryInit()
  endif
  autocmd! spacevimAutoPairs
endfunction

augroup spacevimAutoPairs
  autocmd!
  autocmd CursorHold,CursorHoldI,InsertEnter * call <SID>TryInitAutoPairs()
augroup END
