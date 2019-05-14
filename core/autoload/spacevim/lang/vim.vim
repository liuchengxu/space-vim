function! spacevim#lang#vim#GotoAudoloadDefinition(autoload) abort
  if !exists('*'.a:autoload)
    let splited = split(a:autoload, '#')
    if len(splited) == 2
      let path = splited[0].'.vim'
    else
      let path = join(split(a:autoload, '#')[:-2], '/').'.vim'
    endif
    execute 'silent runtime' 'autoload/'.path
  endif

  redir => output
  execute 'silent verbose function' a:autoload
  redir END

  let defined = split(split(output, "\n")[1])[-1]

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
