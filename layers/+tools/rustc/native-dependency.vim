function! Build(native) abort
  let python = (g:spacevim.os.windows ? 'python ' : './')
  call system(python.a:native.plugpath.'/src/bootstrap/configure.py '.
    \ '--prefix='.a:native.plugpath.'/install --bindir=bin --libdir=lib'.
    \ ' --sysconfdir=. --disable-docs')

  if filereadable('config.toml')
    " profile=user setting unsupported through configure.py interface
    execute ':tabnew +%s/\\V\#profile\ \=\ \<none\>/profile\ \=\ \"user\"/e|up config.toml'
    call spacevim#util#info('Edit config.toml rustc configuration if desired...')
  endif

  call execute('AsyncRun -cwd='.a:native.plugpath.'/build -mode=term '.
    \ '-pos=tab -post='.
    \ 'call\ spacevim\#vim\#plug\#PostBuild(code,\ ''rust'') @ '.
    \ python.'x.py build && '.python.'x.py install')
endfunction

function! PostBuild(native) abort
  "TODO: Comment?
  "call delete('library', 'rf')
  "call delete('Makefile')
  "call delete('src', 'rf')
  " Install rg and fd tools if not on system
  if executable('rg') != 1
    call spacevim#vim#plug#post_update('', 'cargo install --locked ripgrep')
  endif
  if executable('fd') != 1
    call spacevim#vim#plug#post_update('', 'cargo install --locked fd-find')
  endif
  if executable('delta') != 1
    call spacevim#vim#plug#post_update('', 'cargo install --locked git-delta')
  endif
  if executable('bat') != 1
    call spacevim#vim#plug#post_update('', 'cargo install --locked bat')
  endif
endfunction

let g:spacevim#vim#plug#native_dependency = get(g:, 'spacevim#vim#plug#native_dependency', {})
let g:spacevim#vim#plug#native_dependency['rust'] = {
  \ 'bin': 'rustc',
  \ 'override': '$RUSTC',
  \ 'repo': 'rust-lang/rust',
  \ 'vregex': '\Vrustc \(\[0-9]\+\).\(\[0-9]\+\).\(\[0-9]\+\)',
  \ 'v_req': [1, 56, 0],
  \ 'Build': function('Build'),
  \ 'PostBuild': function('PostBuild'),
\ }
