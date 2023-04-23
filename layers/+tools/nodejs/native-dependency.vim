function! Build(native) abort
  if !a:native.posix_compiler
    " vcbuild appears to not have '--prefix' equivalent but can improvise
    call execute('AsyncRun -cwd='.a:native.plugpath.'/build -mode=term '.
      \ '-pos=tab -post='.
      \ 'call\ spacevim\#vim\#plug\#PostBuild(code,\ ''node'') @ '.
      \ '.\\vcbuild openssl-no-asm')
  else
    let configure_log = a:native.temppath.'/nodejs_configure.log'
    call system(a:native.plugpath.'/configure --prefix='.
      \ a:native.plugpath.'/install'.a:native.ninja_flag.' > '.
      \ configure_log)
    call rename(configure_log, a:native.plugpath.'/configure.log')
    call execute('AsyncRun -cwd='.a:native.plugpath.'/build -mode=term '.
      \ '-pos=tab -program=make -post='.
      \ 'call\ spacevim\#vim\#plug\#PostBuild(code,\ ''node'') @ '.
      \ 'install'.a:native.jobs_flag)
  endif
endfunction

function! PostBuild(native) abort
  call delete('config.gypi')
  call delete('config.mk')
  call delete('config.status')
  call delete('icu_config.gypi')
  call delete('deps', 'rf')
  call delete('node')
  call delete('__pycache__', 'rf')
  call delete('tools', 'rf')

  execute 'tcd' a:native.binpath
  call system('node corepack enable')
endfunction

let g:spacevim#vim#plug#native_dependency = get(g:, 'spacevim#vim#plug#native_dependency', {})
let g:spacevim#vim#plug#native_dependency['node'] = {
  \ 'bin': 'node',
  \ 'override': '$NODE',
  \ 'repo': 'nodejs/node',
  \ 'vregex': '\Vv\(\[0-9]\+\).\(\[0-9]\+\).\(\[0-9]\+\)',
  \ 'v_req': [16, 10, 0],
  \ 'Build': function('Build'),
  \ 'PostBuild': function('PostBuild'),
\ }
