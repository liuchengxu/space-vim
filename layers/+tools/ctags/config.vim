let g:gutentags_ctags_tagfile = '.tags'
" set default tags file name `tags` to `.tags`
set tags=./.tags;,.tags

let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

let g:gutentags_modules = g:spacevim#vim#ctags#modules

" Specifies a directory in which to create all the tags files
let g:gutentags_cache_dir = g:spacevim#vim#ctags#cache_dir

let g:gutentags_auto_add_gtags_cscope = 0
