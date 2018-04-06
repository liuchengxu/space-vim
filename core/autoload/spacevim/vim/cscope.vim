function! s:add_db()
  " add any database in current directory
  let db = findfile('cscope.out', '.;')
  " :h cscope-suggestions
  set nocsverb
  if !empty(db)
    silent cs reset
    silent! execute 'cs add' db
  " else add database pointed to by environment
  elseif !empty($CSCOPE_DB)
    silent cs reset
    silent! execute 'cs add' $CSCOPE_DB
  endif
  set csverb
endfunction

function! spacevim#vim#cscope#Build(timer, ...)
  let git_dir = system('git rev-parse --git-dir')
  let chdired = 0
  if !v:shell_error
    let chdired = 1
    execute 'cd' substitute(fnamemodify(git_dir, ':p:h'), ' ', '\\ ', 'g')
  endif

  let exts = empty(a:000) ?
    \ ['java', 'c', 'h', 'cc', 'hh', 'cpp', 'hpp'] : a:000

  let cmd = "find . " . join(map(exts, "\"-name '*.\" . v:val . \"'\""), ' -o ')
  let tmp = tempname()
  try
    call system(cmd.' | grep -v /test/ > '.tmp)
    call system('cscope -b -q -i'.tmp)
    call s:add_db()
  finally
    silent! call delete(tmp)
    if chdired
      cd -
    endif
  endtry
endfunction

function! spacevim#vim#cscope#Setup()
  call timer_start(100, 'spacevim#vim#cscope#Build')
endfunction

function! spacevim#vim#cscope#UpdateDB()
  if filereadable('cscope.out')
    call spacevim#vim#cscope#Build()
  endif
endfunction

function! spacevim#vim#cscope#Find(type)
  if a:type == 'symbol'
    :cs find s <cword>
  elseif a:type == 'global'
    :cs find g <cword>
  elseif a:type == 'calls'
    :cs find c <cword>
  elseif a:type == 'text'
    :cs find t <cword>
  elseif a:type == 'egrep'
    :cs find e <cword>
  elseif a:type == 'file'
    :cs find f <cfile>
  elseif a:type == 'includes'
    :cs find i <cfile>
  elseif a:type == 'called'
    :cs find d <cword>
  endif
endfunction
