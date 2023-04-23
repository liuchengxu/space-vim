function! spacevim#vim#plug#download(dein_path) abort
  echo '==> Downloading Shougo/dein.vim ......'
  execute '!git clone --depth=1 https://github.com/Shougo/dein.vim '.a:dein_path
endfunction

" Store dein merged rtp and/or cache in tmpfs
function! spacevim#vim#plug#dein_cache_setup() abort
  let s:dein_cache = { 'dir':
    \ fnamemodify(g:spacevim_plug_home.'/.cache', ':p'),
    \ 'target': fnamemodify(tempname(), ':h:h').
    \   '/.vimcache'.(g:spacevim.os.windows ? '' : $USER) }
  let dc = s:dein_cache
  let dc.statefile = { 'name': '/state_'.v:progname.'.vim' }
  let dc.statefile.linkname = fnamemodify(
    \ g:spacevim_plug_home.dc.statefile.name, ':p')
  let dc.cachefile = { 'name': '/cache_'.v:progname }
  let dc.cachefile.linkname = fnamemodify(
    \ g:spacevim_plug_home.dc.cachefile.name, ':p')
  if !isdirectory(dc.dir)
    if !isdirectory(dc.target)
      call mkdir(dc.target, 'p', '0o700')
    endif
    let dc.type = getftype(dc.dir)
    if dc.type !=# 'link'
      let ret = empty(dc.type) ? v:false : delete(dc.dir)
      if ret == v:false
        call spacevim#util#SymbolicLink(dc.target, dc.dir)
      endif
    endif
  endif

  if g:spacevim_enable_plug_merge && !isdirectory(dc.target.'/vimrc/.dein')
    let g:spacevim.enable_dein_recache = v:true
  endif

  if g:spacevim_enable_plug_cache
    for i in [dc.statefile, dc.cachefile]
      if getftype(i.linkname) !=# 'link'
        call spacevim#util#SymbolicLink(dc.target.i.name, i.linkname)
      endif
    endfor
  endif

  let g:spacevim#vim#plug#native_dependency = {}
endfunction

function! spacevim#vim#plug#dein_cache_clear() abort
  " dein#clear_state() doesn't work with symlinks
  for i in [s:dein_cache.statefile, s:dein_cache.cachefile]
    if filereadable(i.linkname)
      call delete(s:dein_cache.target.i.name)
    endif
  endfor
endfunction

" Avoid hit-enter prompt when the message being echoed is too long.
function! s:truncate(msg) abort
  let l:maxlen = &columns * &cmdheight - 2
  let l:maxlen = &showcmd ? l:maxlen - 11 : l:maxlen
  let l:maxlen = &ruler ? l:maxlen - 18 : l:maxlen
  return len(a:msg) < maxlen ? a:msg : a:msg[:maxlen-3].'...'
endfunction

" Backwards compatibility for vim-plug Plug command using Dein.vim
function! spacevim#vim#plug#Plug(repo, ...) abort
  if a:0 > 1
    return spacevim#util#err('Invalid number of arguments (1..2)')
  endif

  try
    let repo = substitute(a:repo, '[\/]\+$', '', '')
    let opts = a:0 == 1 ? a:1 : {}
    let opts.merged = v:false
    let local = fnamemodify(g:spacevim_plug_home.'/'.repo, ':p:h')
    call dein#add(isdirectory(local) ? local : repo, opts)
  catch
    return spacevim#util#err(repo . ' ' . v:exception)
  endtry
endfunction

function! s:setup_vim_plug_links() abort
  " This is how dein appears to queue up plugins to update internally:
  "let plugins = dein#util#_get_plugins(a:plugins)
  "let plugins = filter(plugins, { _, val -> !isdirectory(val.path) })

  " s:missing is calculated differently, maybe it will work
  for [k,v] in items(s:missing)
    let vim_plug_dir = fnamemodify(g:spacevim_plug_home.'/'.k, ':p:h')
    let dein_dir = fnamemodify(v.path, ':p')
    let relative = dein_dir[len(fnamemodify(g:spacevim_plug_home, ':p')):]
    call spacevim#util#SymbolicLink(relative, vim_plug_dir)
  endfor
endfunction

" Automatically install missing plugins on startup
function! spacevim#vim#plug#check(...) abort
  " First migrate from vim-plug to dein structure
  let dein_status = copy(dein#get())
  let s:missing = filter(dein_status, {k,v -> !dein#is_available(k)})
  let migration_notice = 0
  if len(s:missing)
    for [k,v] in items(s:missing)
      let vim_plug_dir = fnamemodify(g:spacevim_plug_home.'/'.k, ':p')
      let dein_parent_dir = fnamemodify(v.path, ':p:h')
      let dein_dir = fnamemodify(v.path, ':p')
      if v.type ==# 'git' && getftype(vim_plug_dir) ==# 'dir'
        if !isdirectory(dein_parent_dir)
          call mkdir(dein_parent_dir, 'p')
        endif
        call rename(vim_plug_dir, dein_dir)
        let relative = dein_dir[len(fnamemodify(g:spacevim_plug_home, ':p')):]
        let vim_plug_dir = fnamemodify(vim_plug_dir, ':h')
        call spacevim#util#SymbolicLink(relative, vim_plug_dir)
        let migration_notice = v:true
      endif
    endfor
    if migration_notice
      let vim_plug_file = g:spacevim.base.'/autoload/plug.vim'
      let msg_renamed = ''
      if filereadable(vim_plug_file)
        call rename(vim_plug_file, vim_plug_file.'.old')
        let msg_renamed = ' ''autoload/plug.vim'' renamed to '.
          \ '''autoload/plug.vim.old''.'
      endif
      call spacevim#util#info('Migrated some vim-plug packages to dein.'.
        \ ' Notice vim-plug''s ''on'', ''for'', ''do'', ''dir'' package'.
        \ ' options are silently ignored. Replace them with dein''s '.
        \ 'options: ''on_cmd'', ''on_func'', ''on_ft'', ''build'', '.
        \ '''hook_done_update'', ''path'', and others.'.msg_renamed)
    endif
    let g:spacevim.enable_dein_recache = v:true
  endif
  " Now check for missing plugins after migration
  if migration_notice
    call filter(s:missing, {k,v -> !dein#is_available(k)})
  endif
  if len(s:missing)
    let l:msg = '[space-vim] Need to install the missing plugins: '
    let l:msg .= join(keys(s:missing), ',').' (y/N): '
    if a:0 == 1
      if exists('*popup_dialog')
        call s:popup_dialog(l:msg)
      elseif s:ask(l:msg)
        call s:setup_vim_plug_links()
        silent call dein#install()
        let g:spacevim.enable_dein_recache = v:true
      endif
    else
      echom l:msg
      call s:setup_vim_plug_links()
      call dein#install()
      let g:spacevim.enable_dein_recache = v:true
    endif
  endif
  unlet s:missing
endfunction

function! s:dialog_handler(id, result) abort
  if a:result
    call popup_close(a:id)
    call s:setup_vim_plug_links()
    silent call dein#install()
    let g:spacevim.enable_dein_recache = v:true
  endif
endfunction

function! s:popup_dialog(msg) abort
  call popup_dialog(a:msg, {
        \ 'filter': 'popup_filter_yesno',
        \ 'callback': function('s:dialog_handler'),
        \ })
endfunction

function! s:ask(message) abort
  call inputsave()
  echohl WarningMsg
  let answer = input(a:message)
  echohl None
  call inputrestore()
  echo "\r"
  return (answer =~? '^y') ? 1 : 0
endfunction

function! spacevim#vim#plug#post_update(name, cmd) abort
  if !empty(a:name)
    let cwd = getcwd()
    let plugpath = dein#get(a:name).path
    execute 'tcd' plugpath
  endif
  let make = a:cmd =~# '^make'
  let cmd = make ? strcharpart(a:cmd, 4) : a:cmd
  if dein#is_available('asyncrun.vim')
    execute('AsyncRun -mode=term -pos=tab '.(make?'-program=make ':'').'@ '.cmd)
  else
    call system(a:cmd)
  endif
  if !empty(a:name)
    execute 'tcd' cwd
  endif
endfunction

" Params:
"  [in] plugname: e.g. 'rust', 'node', 'ctags'
" Returns list [location, [v_maj, v_min, ...], binpath], location may be
"  'override', 'plugin', 'system', or 'none'. Note ['none'] case.
function! spacevim#vim#plug#LocateDependency(plugname) abort
  let c = g:spacevim#vim#plug#native_dependency[a:plugname]
  " To speedup startuptime try cached `--version` rather than wait:
  let f = g:spacevim.state_base.'version_'.a:plugname
  let v = filereadable(f) ? readfile(f) : []
  if len(v) >= 2
    if v[0][0] > c.v_req[0] || (v[0][0] == c.v_req[0] && v[0][1] >= c.v_req[1])
      if len(v) == 3
        call spacevim#util#PrefixPATH(v[2])
      endif
      return [v[1], v[0], v[2]]
    endif
  endif
  function! Update(l, f) abort
    try
      call writefile(a:l, a:f, 'S')
    catch
      call spacevim#util#err('Failed to write cache file: "'.a:f.
        \ '" exception: "'.v:exception.'"')
    endtry
  endfunction
  let fr = has_key(c, 'feature_req') ? c.feature_req : []
  if has_key(c, 'override') && exists(c.override)
    let v = spacevim#util#IsVersionSufficient(c.override, c.vregex, c.v_req, fr)
    if v[0]
      let binpath = fnamemodify(c.override, ':h')
      call spacevim#util#PrefixPATH(binpath)
      call Update([string(v[1]), 'override', binpath], f)
      return ['override', v[1], binpath]
    endif
  endif
  " dein might install 'node' into e.g. 'node_v16.16.0' if 'rev' is set.
  let globs = reverse(glob(g:spacevim_plug_home.'/repos/github.com/'.
    \ c.repo.'*/install/bin', v:true, v:true))
  for binpath in globs
    let v = spacevim#util#IsVersionSufficient(binpath.'/'.c.bin,
      \ c.vregex, c.v_req, fr)
    if v[0]
      call spacevim#util#PrefixPATH(binpath)
      call Update([string(v[1]), 'plugin', binpath], f)
      return ['plugin', v[1], binpath]
    endif
  endfor
  let v = spacevim#util#IsVersionSufficient(c.bin, c.vregex, c.v_req, fr)
  if v[0]
    call Update([string(v[1]), 'system'], f)
    return ['system', v[1]]
  endif
  return ['none']
endfunction

" plugname is e.g. 'rust', 'node', 'ctags'
function! spacevim#vim#plug#Build(plugname) abort
  let c = g:spacevim#vim#plug#native_dependency[a:plugname]
  if !dein#is_available('asyncrun.vim')
    call spacevim#util#info(a:plugname.' requires asyncrun.vim to '.
      \ 'build. Add "programming" layer to .spacevim')
    return
  endif

  let c.posix_compiler = v:true
  if (!exists('$CC') && executable('gcc') != 1) ||
    \ executable('make') != 1 || executable('python3') != 1 ||
    \ executable('ninja') != 1
    let c.posix_compiler = v:false
    if !g:spacevim.os.windows
      call spacevim#util#info('Unable to build '.a:plugname.', requires'.
        \ ' a C++ compiler, make, python3, and ninja. After rectifying '.
        \ 'try `:call dein#get('.a:plugname.').hook_post_update()`')
      return
    endif
  endif

  if g:spacevim.os.windows
    if executable('python') != 1
      call spacevim#util#info('Requires python on PATH. After '.
      \ 'rectifying try `:call dein#get('.a:plugname.').hook_post_update()`')
      return
    endif
    if !c.posix_compiler && !exists('$VCINSTALLDIR')
      call spacevim#util#info('Suitable Cygwin, MSYS2, or MSVC '.
        \ 'environment not detected. Per desired ABI run '.
        \ 'msys2_shell.cmd in the case of MSYS2, or vcvars64.bat in '.
        \ 'the Vim Shell in the case of MSVC. After rectifying try '.
        \ '`:call dein#get('.a:plugname.').hook_post_update()`')
      return
    endif
  endif

  if c.posix_compiler
    let c.ninja_flag = ''
    let c.jobs_flag = ''
    if executable('ninja')
      let c.ninja_flag=' --ninja'
    else
      " Determine number of cores/threads for make -j, ninja autodetects
      let num_threads = 4
      if executable('lscpu')
        let result = system("lscpu | grep -E '?^(CPU\\(s\\):|Thread\\(s\\) per core:)' | tr -s ' ' | cut -f 2 -d:")
        if !v:shell_error
          let num_threads = join(split(result), '*')
        endif
      endif
      let c.jobs_flag = ' -j '.num_threads
    endif
  endif

  call spacevim#util#info('Building '.a:plugname.'...')

  let plugpath = dein#get(a:plugname).path
  call extend(c, {'cwd': getcwd(), 'plugpath': plugpath,
    \ 'temppath': fnamemodify(tempname(), ':p:h')})
  execute 'tcd' plugpath

  if g:spacevim_enable_temp_build && getftype('build') !=# 'dir'
    let temppath = c.temppath.'/build'
    call mkdir(temppath, 'p')
    call delete('build')
    call spacevim#util#SymbolicLink(temppath, 'build')
  endif

  execute 'tcd build'
  call c.Build(c)
  execute 'tcd' c.cwd
endfunction

function! spacevim#vim#plug#PostBuild(exit_code, plugname) abort
  let c = g:spacevim#vim#plug#native_dependency[a:plugname]
  execute 'tcd' c.plugpath
  if a:exit_code != 0
    call spacevim#util#info(a:plugname.' build failure exit code:'.a:exit_code)
  else
    " Delete the repo we have the build product
    call system('git read-tree -u --reset $(git hash-object -t tree '.
      \ (g:spacevim.os.windows ? 'NUL' : '/dev/null').')')
    call delete('.git', 'rf')

    call delete((g:spacevim_enable_temp_build ? c.temppath.'/' : '').
      \ 'build', 'rf')

    let c.binpath = fnamemodify(c.plugpath.'/install/bin', ':p:h')
    if isdirectory(c.binpath)
      call spacevim#util#PrefixPATH(c.binpath)
    endif

    call c.PostBuild(c)

    call dein#disable(a:plugname)
    call spacevim#vim#plug#dein_cache_clear()
  endif
  if g:spacevim_enable_temp_build && getftype(c.plugpath.'/build') ==# 'link'
    call delete(c.plugpath.'/build')
  endif
  execute 'tcd' c.cwd
endfunction
