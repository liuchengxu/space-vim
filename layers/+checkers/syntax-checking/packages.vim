if g:spacevim_vim8 || g:spacevim_nvim
  MP 'w0rp/ale',  { 'on': [] }
  call timer_start(200, 'spacevim#defer#ale')
else
  MP 'scrooloose/syntastic',     { 'on': 'SyntasticCheck' }
endif
