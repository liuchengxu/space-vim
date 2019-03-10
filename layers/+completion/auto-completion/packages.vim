" space-vim will use completor.vim for vim8 by default.
" If you want to use ncm2 when using vim8, configure it explicitly.
" let g:spacevim_use_ncm2 = 1
if exists('g:spacevim_use_ncm2') || has("nvim-0.2.2") && has('python3')
  let s:plugins = [
        \ 'ncm2/ncm2',
        \ 'roxma/nvim-yarp',
        \ 'ncm2/ncm2-bufword',
        \ 'ncm2/ncm2-tmux',
        \ 'ncm2/ncm2-path',
        \ 'ncm2/ncm2-jedi',
        \ 'ncm2/ncm2-github',
        \ 'ncm2/ncm2-racer',
        \ 'ncm2/ncm2-go',
        \ 'ncm2/ncm2-pyclang',
        \ 'ncm2/ncm2-vim', 'Shougo/neco-vim',
        \ ]
  if g:spacevim.vim8
    call add(s:plugins, 'roxma/vim-hug-neovim-rpc')
  endif
  if exists('*nvim_open_win')
    call add(s:plugins, 'ncm2/float-preview.nvim')
  endif
  if spacevim#load('code-snippets')
    call add(s:plugins, 'ncm2/ncm2-ultisnips')
  endif
  " Enable ncm2 for all buffer
  autocmd CursorHold,InsertEnter * call ncm2#enable_for_buffer()
  let g:ncm2#matcher = 'abbrfuzzy'

elseif g:spacevim.vim8
  let s:plugins = [
        \ 'maralla/completor.vim',
        \ 'maralla/completor-neosnippet',
        \ ]

else
  let s:plugins = ['lifepillar/vim-mucomplete']
endif

call extend(g:spacevim.plugins, s:plugins)
