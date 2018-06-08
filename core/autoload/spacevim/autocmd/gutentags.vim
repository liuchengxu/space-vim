let s:modules = ['ctags']

if executable('gtags-cscope') && executable('gtags')
	let s:modules += ['gtags_cscope']
endif

let s:vim_tags = expand('~/.cache/tags')
" create if ~/.cache/tags does not exist
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

let g:spacevim#vim#ctags#cache_dir = s:vim_tags

function! spacevim#autocmd#gutentags#Init()
  let g:gutentags_ctags_tagfile = '.tags'
  " set default tags file name `tags` to `.tags`
  set tags=./.tags;,.tags

  let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
  let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
  let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

  let g:gutentags_modules = s:modules

  " Specifies a directory in which to create all the tags files
  let g:gutentags_cache_dir = s:vim_tags

  let g:gutentags_auto_add_gtags_cscope = 0
endfunction
