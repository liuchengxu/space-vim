let s:vim8 = has('patch-8.0.0039') && exists('*job_start')


if s:vim8
    MP 'w0rp/ale'
else
    MP 'scrooloose/syntastic',     { 'on': 'SyntasticCheck' }
endif

" if s:vim8
    " Plug 'w0rp/ale'
" else
    " Plug 'scrooloose/syntastic',     { 'on': 'SyntasticCheck' }
" endif
