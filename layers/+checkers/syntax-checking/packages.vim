if g:spacevim_vim8 || g:spacevim_nvim
  MP 'w0rp/ale'
else
  MP 'scrooloose/syntastic',     { 'on': 'SyntasticCheck' }
endif
