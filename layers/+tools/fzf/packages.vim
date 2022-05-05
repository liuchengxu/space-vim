if get(g:, 'spacevim_enable_clap', 0)
  MP 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
  MP 'vn-ki/coc-clap'
elseif g:spacevim.gui && !has('terminal')
  MP 'Yggdroot/LeaderF'
else
  if g:spacevim.speed_up_via_timer
    if !executable('fzf')
      MP 'junegunn/fzf',  { 'dir': '~/.fzf', 'do': function('spacevim#VimPlugPostUpdateHook', [v:false, './install --all --xdg']), 'on': [] }
    endif
    MP 'junegunn/fzf.vim', { 'on': [] }
    call timer_start(700, 'spacevim#defer#fzf')
  else
    if !executable('fzf')
      MP 'junegunn/fzf',  { 'dir': '~/.fzf', 'do': function('spacevim#VimPlugPostUpdateHook', [v:false, './install --all --xdg']) }
    endif
    MP 'junegunn/fzf.vim'
  endif
endif
