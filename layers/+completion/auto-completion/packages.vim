if exists('g:spacevim_use_ncm2') || has("nvim-0.2.2") && has('python3')
  let s:plugins = [
        \ 'ncm2/ncm2',
        \ 'roxma/nvim-yarp',
        \ 'ncm2/ncm2-bufword',
        \ 'ncm2/ncm2-tmux',
        \ 'ncm2/ncm2-path',
        \ 'ncm2/ncm2-jedi',
        \ 'ncm2/ncm2-github',
        \ 'ncm2/ncm2-abbrfuzzy',
        \ 'ncm2/ncm2-racer',
        \ 'ncm2/ncm2-go',
        \ 'ncm2/ncm2-pyclang',
        \ ]
  if g:spacevim.vim8
    call add(s:plugins, 'roxma/vim-hug-neovim-rpc')
  endif
  " enable ncm2 for all buffer
  autocmd BufEnter * call ncm2#enable_for_buffer()

elseif g:spacevim.vim8
  let s:plugins = [
        \ 'maralla/completor.vim',
        \ 'maralla/completor-neosnippet',
        \ ]

else
  let s:plugins = ['lifepillar/vim-mucomplete']
endif

call extend(g:spacevim.plugins, s:plugins)
