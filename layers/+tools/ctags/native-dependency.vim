" Need to add libyaml/install/lib to LD_LIBRARY_PATH for ctags runtime
"  but dein doesn't manage plugpath once built, so look at state
" For spacevim#vim#plug#LocateDependency in packages.vim and cache.vim
let f = g:spacevim.state_base.'libyaml_state'
if filereadable(f)
  let p = readfile(f)
  if len(p) > 0
    if match($LD_LIBRARY_PATH, '\V'.p[0]) == -1
      let $LD_LIBRARY_PATH .= (empty($LD_LIBRARY_PATH) ? '' :
        \ spacevim#util#PathEnvSep()).p[0]
    endif
  endif
endif

function! BuildCtags(native) abort
  if executable('rst2man') != 1
    call spacevim#util#info('Unable to build ctags man pages unless '.
      \ 'rst2man in python3-docutils is installed.')
  endif

  if a:native.posix_compiler
    execute 'tcd' a:native.plugpath
    let autoconf_log = a:native.temppath.'/ctags_autoconf.log'
    call system('./autogen.sh > '.autoconf_log)
    call rename(autoconf_log, a:native.plugpath.'/autoconf.log')

    execute 'tcd build'
    let configure_log = a:native.temppath.'/ctags_configure.log'
    call system(a:native.plugpath.'/configure --enable-yaml --prefix='.
      \ a:native.plugpath.'/install > '.configure_log)
    call rename(configure_log, a:native.plugpath.'/configure.log')
    call execute('AsyncRun -cwd='.a:native.plugpath.'/build '.
      \ '-mode=term -pos=tab -program=make -post='.
      \ 'call\ spacevim\#vim\#plug\#PostBuild(code,\ ''ctags'') @ '.
      \ 'install'.a:native.jobs_flag)
  endif
endfunction

function! PostBuildCtags(native) abort
  call delete('autom4te.cache', 'rf')
  call delete('gnulib', 'rf')
  call delete('man', 'rf')
  call delete('aclocal.m4')
  call delete('config.guess')
  call delete('config.h.in')
  call delete('config.h.in~')
  call delete('config.sub')
  call delete('configure')
  call delete('depcomp')
  call delete('install-sh')
  call delete('last-aclocal.m4')
  call delete('Makefile.in')
  call delete('missing')
endfunction

function! BuildYaml(native) abort
  if executable('autoconf') != 1
    call spacevim#util#info('Unable to build libyaml, requires'.
      \ ' autoconf. After rectifying try `:call '.
      \ 'dein#get(''libyaml'').hook_post_update()`')
  else
    if a:native.posix_compiler
      execute 'tcd' a:native.plugpath
      let autoconf_log = a:native.temppath.'/libyaml_autoconf.log'
      call system('./bootstrap > '.autoconf_log)
      call rename(autoconf_log, a:native.plugpath.'/autoconf.log')

      execute 'tcd build'
      let configure_log = a:native.temppath.'/libyaml_configure.log'
      call system(a:native.plugpath.'/configure --prefix='.
        \ a:native.plugpath.'/install > '.configure_log)
      call rename(configure_log, a:native.plugpath.'/configure.log')
      call execute('AsyncRun -cwd='.a:native.plugpath.'/build '.
        \ '-mode=term -pos=tab -program=make -post='.
        \ 'call\ spacevim\#vim\#plug\#PostBuild(code,\ ''libyaml'') @ '.
        \ 'install'.a:native.jobs_flag)
    endif
  endif
endfunction

function! PostBuildYaml(native) abort
  if a:native.posix_compiler
    " And PKG_CONFIG_PATH so that ctags configure can find libyaml
    " And LD_LIBRARY_PATH so that library can be found at runtime
    let ps = spacevim#util#PathSep()
    let eps = spacevim#util#PathEnvSep()
    let l = a:native.plugpath.ps.'install'.ps.'lib'
    let $PKG_CONFIG_PATH .= (empty($PKG_CONFIG_PATH) ? '' : eps).l.'/pkgconfig'
    let $LD_LIBRARY_PATH .= (empty($LD_LIBRARY_PATH) ? '' : eps).l
    " Put into a statefile so that it can be loaded before version check
    let f = g:spacevim.state_base.'libyaml_state'
    call writefile([l], f, 'S')
  endif
  call delete('autom4te.cache', 'rf')
  call delete('config', 'rf')
  call delete('include', 'rf')
  call delete('src', 'rf')
  call delete('tests', 'rf')
  call delete('aclocal.m4')
  call delete('configure')
  call delete('Makefile.in')
  " Can't rely on dein to wait for libyaml to build to then build ctags
  execute 'tcd' a:native.cwd
  call spacevim#vim#plug#Build('ctags')
endfunction

let g:spacevim#vim#plug#native_dependency = get(g:,
  \ 'spacevim#vim#plug#native_dependency', {})
  " Unfortunately plugin built ctags doesn't include YYYYMMDD versioning
  "\ vregex: '\V\%(p\)\@<=\(\[0-9]\+\).\(\[0-9]\+\).\(\[0-9]\{4}\)'.
  "  \ '\(\[0-9]\{2}\)\(\[0-9]\{2}\)',
  "\ v_req: [5, 9, 2022, 8, 7],
let g:spacevim#vim#plug#native_dependency['ctags'] = {
  \ 'bin': 'ctags',
  \ 'repo': 'universal-ctags/ctags',
  \ 'vregex': '\V\^Universal Ctags \(\[0-9]\+\).\(\[0-9]\+\).\(\[0-9]\+\)(',
  \ 'v_req': [5, 9, 0],
  \ 'feature_req': ['--list-features', '\V\nyaml'],
  \ 'Build': function('BuildCtags'),
  \ 'PostBuild': function('PostBuildCtags'),
\ }
let g:spacevim#vim#plug#native_dependency['libyaml'] = {
  \ 'repo': 'yaml/libyaml',
  \ 'Build': function('BuildYaml'),
  \ 'PostBuild': function('PostBuildYaml'),
\ }
