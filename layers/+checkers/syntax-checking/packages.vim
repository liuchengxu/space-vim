if g:spacevim.vim8 || g:spacevim.nvim
  MP 'w0rp/ale',  { 'on': [] }
  call timer_start(200, 'spacevim#defer#ale')
else
  MP 'scrooloose/syntastic',     { 'on': 'SyntasticCheck' }
endif
