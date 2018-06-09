if g:spacevim.timer
  MP 'rust-lang/rust.vim', { 'on': [] }
else
  MP 'rust-lang/rust.vim', { 'for': 'rust' }
endif
autocmd! User rust.vim call spacevim#autocmd#rust#Init()
