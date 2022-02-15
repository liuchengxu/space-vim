function! spacevim#github#CommitRef() abort
  let root_dir = clap#path#find_project_root(bufnr(''))

  " Not a git repo
  if empty(root_dir)
    return
  endif

  let abs_path = expand('%:p')

  if abs_path =~ '^'.root_dir
    " /autoload/clap/rooter.vim
    let relative_path = abs_path[strlen(root_dir):]
  else
    echoerr 'abs_path:'.abs_path.', root_dir:'.root_dir.' mismatches.'
    return
  endif

  " https://github.com/liuchengxu/vim-clap/blob/d8ff7dc8b41e3be15810718163202df0c1122405/crates/fuzzy_filter/src/lib.rs#L59
  let output = systemlist('git remote -v')
  let origin = filter(output, 'v:val =~ "^origin"')
  if empty(origin)
    echoerr 'On origin remote info'
    return
  endif

  " https://github.com/liuchengxu/vim-clap{.git}
  let remote_url = split(origin[0])[1]

  if remote_url =~# '.git$'
    let remote_url = substitute(remote_url, '.git$', '', '')
  endif

  " https://ghp_TOKEN@github.com/subspace/subspace
  if remote_url =~# 'https://gh._.*@github.com'
    let remote_url = substitute(remote_url, 'https://\zsgh._.*@\zegithub.com', '', '')
  endif

  let rev = systemlist('git rev-parse HEAD')[0]

  let commit_url = printf('%s/blob/%s%s#L%d', remote_url, rev, relative_path, line('.'))

  let @+ = commit_url

  echohl WarningMsg
  echon commit_url
  echohl NONE

  echohl Normal
  echon ' copied to your clipboard'
  echohl NONE
endfunction
