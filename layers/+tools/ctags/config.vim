execute 'source '.fnamemodify(expand('<sfile>'), ':h').'/native-dependency.vim'

if spacevim#vim#plug#LocateDependency('ctags')[0] ==# 'none'
  call spacevim#util#warn('ctags layer failure, try ":call dein#get('.
    \ '"libyaml").hook_post_update()" to build ctags+libyaml as plugin,'.
    \ ' or set $PATH to existing build, or install system-wide with '.
    \ 'version >= '.join(g:spacevim#vim#plug#native_dependency[
    \ 'ctags'].v_req, '.').'.')
endif

" vim-gutentags {
  let g:gutentags_ctags_extra_args = get(g:, 'gutentags_ctags_extra_args', [])
  let g:gutentags_ctags_extra_args += ['--fields=+niazS', '--extras=+q',
    \ '--excmd=number', '--tag-relative=yes']
  let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
  let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" }
