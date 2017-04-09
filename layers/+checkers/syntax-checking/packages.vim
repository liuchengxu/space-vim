if g:spacevim_vim8 || g:spacevim_nvim
    MP 'w0rp/ale', { 'on': 'ALEEnable' }
else
    MP 'scrooloose/syntastic',     { 'on': 'SyntasticCheck' }
endif
