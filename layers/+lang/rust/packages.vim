" Rust package manager uses toml syntax.
MP 'cespare/vim-toml'

if g:spacevim.speed_up_via_timer
  MP 'rust-lang/rust.vim', { 'on': [] }
else
  MP 'rust-lang/rust.vim', { 'for': 'rust' }
endif
autocmd! User rust.vim call spacevim#autocmd#rust#Init()
