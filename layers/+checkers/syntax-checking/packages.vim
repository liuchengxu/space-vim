let s:vim8 = has('patch-8.0.0039') && exists('*job_start')


if s:vim8 || has('nvim')
    MP 'w0rp/ale'
else
    MP 'scrooloose/syntastic',     { 'on': 'SyntasticCheck' }
endif
