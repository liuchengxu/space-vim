let g:gutentags_ctags_tagfile = '.tags'
" set default tags file name `tags` to `.tags`
set tags=./.tags;,.tags

let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" vim-gutentags currenly only works well with ctags
" let g:gutentags_modules = ['ctags', 'cscope']

let s:vim_tags = expand('~/.cache/tags')

" create if ~/.cache/tags does not exist
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" Specifies a directory in which to create all the tags files
let g:gutentags_cache_dir = s:vim_tags
