if g:spacevim.vim8 || g:spacevim.nvim
  MP 'w0rp/ale',  { 'lazy': g:spacevim.speed_up_via_timer }
else
  MP 'vim-syntastic/syntastic',     { 'on_cmd': 'SyntasticCheck' }
endif
