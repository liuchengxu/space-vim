let g:spacevim#vim#ctags#modules = ['ctags']

if executable('gtags-cscope') && executable('gtags')
	let g:spacevim#vim#ctags#modules += ['gtags_cscope']
endif

let s:vim_tags = expand('~/.cache/tags')
" create if ~/.cache/tags does not exist
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

let g:spacevim#vim#ctags#cache_dir = s:vim_tags
