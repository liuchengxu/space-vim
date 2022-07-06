if get(g:, 'spacevim_enable_clap', 0)
  MP 'liuchengxu/vim-clap', { 'hook_post_update': ':Clap install-binary!' }
  MP 'vn-ki/coc-clap'
elseif g:spacevim.gui && !has('terminal')
  MP 'Yggdroot/LeaderF'
else
  MP 'junegunn/fzf', { 'path': '~/.fzf', 'hook_post_update':
    \ function('spacevim#vim#plug#post_update', ['fzf', './install --all']),
    \ 'lazy': g:spacevim.speed_up_via_timer }
  MP 'junegunn/fzf.vim', { 'lazy': g:spacevim.speed_up_via_timer }
endif
