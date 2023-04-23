execute 'source '.fnamemodify(expand('<sfile>'), ':h').'/native-dependency.vim'

if spacevim#vim#plug#LocateDependency('rust')[0] ==# 'none'
  call spacevim#util#warn('rustc layer failure, try ":call dein#get('.
    \ '"rust").hook_post_update()" to build as plugin, or set $RUSTC/'.
    \ '$PATH to existing build, or install system-wide with version >= '.
    \ join(g:spacevim#vim#plug#native_dependency['rust'].v_req, '.').'.')
else
  " Add cargo installed binaries to PATH, e.g. deno, tree-sitter
  if exists('$CARGO_INSTALL_ROOT')
    call spacevim#util#PostfixPATH(expand('$CARGO_INSTALL_ROOT/bin'))
  elseif exists('$CARGO_HOME')
    call spacevim#util#PostfixPATH(expand('$CARGO_HOME/bin'))
  else
    call spacevim#util#PostfixPATH(expand('$HOME/.cargo/bin'))
  endif
endif
