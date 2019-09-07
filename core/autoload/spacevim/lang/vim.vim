function! s:TryAutoload(autoload) abort
  if !exists('*'.a:autoload)
    let splited = split(a:autoload, '#')
    if len(splited) == 2
      let path = splited[0].'.vim'
    else
      let path = join(split(a:autoload, '#')[:-2], '/').'.vim'
    endif
    execute 'silent runtime' 'autoload/'.path
  endif

  if !exists('*'.a:autoload)
    call spacevim#util#warn(a:autoload." is undefined function")
    return
  endif

  redir => output
  execute 'silent verbose function' a:autoload
  redir END
  " vim: Last set from ~/.space-vim/core/autoload/spacevim/util.vim line 88
  " neovim: Last set from ~/.space-vim/core/autoload/spacevim/util.vim
  let defined = split(split(output, "\n")[1])[3]
  let abs_path = expand(defined)
  let idx = 1
  for line in readfile(abs_path)
    if line =~ '^function '.a:autoload || line =~ '^function! '.a:autoload
      break
    endif
    let idx += 1
  endfor
  execute 'edit' abs_path
  let line = getline(idx)
  let [_, start, _] = matchstrpos(line, a:autoload)
  call cursor(idx, start+1)
endfunction

function! s:TrySID(SID) abort
  let cword = a:SID
  let line = getline('.')
  let [_, start, end] = matchstrpos(line, cword)
  let lines = getbufline(bufname(''), 1, '$')
  let idx = 1
  for line in lines
    if line =~ '^function s:'.cword || line =~ '^function! s:'.cword
      break
    endif
    let idx += 1
  endfor
  call cursor(idx, start+4)
endfunction

function! spacevim#lang#vim#Goto() abort
  let cword = expand('<cword>')
  if cword =~# '\(.#\)\+'
    call s:TryAutoload(cword)
  else
    call s:TrySID(cword)
  endif
endfunction
