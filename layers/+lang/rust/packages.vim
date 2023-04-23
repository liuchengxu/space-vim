" Rust package manager uses toml syntax.
MP 'cespare/vim-toml'

if g:spacevim.speed_up_via_timer
  MP 'rust-lang/rust.vim', { 'lazy': 1,
    \ 'hook_source': function('spacevim#autocmd#rust#Init') }
else
  MP 'rust-lang/rust.vim', { 'on_ft': 'rust',
    \ 'hook_source': function('spacevim#autocmd#rust#Init') }
endif
