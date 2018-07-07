let s:is_building = 0

" Use s:add_db for both async callback and sync mode
function! s:add_db(channel)
  " add any database in current directory
  let db = findfile('cscope.out', '.;')
  " :h cscope-suggestions
  set nocsverb
  if !empty(db)
    " FIXME: when building cscope using job api at the first time, cscope.in.out won't be generated.
    " Thus it raises errors when running `cs add`, use try-catch to rebuild cscope.
    try
      silent cs reset
      silent! execute 'cs add' db
    catch
      call s:build_async(g:spacevim_cscope_cmd)
    endtry
  " else add database pointed to by environment
  elseif !empty($CSCOPE_DB)
    silent cs reset
    silent! execute 'cs add' $CSCOPE_DB
  else
    call s:build_async(g:spacevim_cscope_cmd)
  endif
  set csverb
  let s:is_building = 0
  echo "\r\r"
  call s:find_after()
endfunction

function! s:build_sync(...)
  for cmd in a:000
    call system(cmd)
  endfor
  call s:add_db('')
endfunction

function! s:find_after()
  if exists('s:find_after_build')
    call spacevim#vim#cscope#Find(s:find_after_build)
    unlet s:find_after_build
  endif
endfunction

function! s:on_exit_cb(job_id, data, event) dict
  call s:add_db('')
endfunction

function! s:build_async(cmd)
  let g:spacevim_cscope_cmd = a:cmd
  if g:spacevim.nvim
    let job = jobstart(['bash', '-c', a:cmd], { 'on_exit': function('s:on_exit_cb') })
  else
    let job = job_start(['bash', '-c', a:cmd], { 'close_cb': function('s:add_db') })
  endif
endfunction

function! s:build()
  let s:is_building = 1
  let root_dir = spacevim#util#RootDirectory()
  let exts = empty(a:000) ?
    \ ['java', 'c', 'h', 'cc', 'hh', 'cpp', 'hpp'] : a:000

  let tmp = tempname()
  let cmd = "find ".root_dir." " . join(map(exts, "\"-name '*.\" . v:val . \"'\""), ' -o ')
  let cmd1 = cmd.' | grep -v /test/ > '.tmp
  let cmd2 = 'cscope -b -q -i'.tmp
  try
    if exists('*job_start') || exists('*jobstart')
      call s:build_async(cmd1 . ' && ' . cmd2)
    else
      call s:build_sync(cmd1, cmd2)
    endif
  finally
    silent! call delete(tmp)
  endtry
endfunction

function! spacevim#vim#cscope#Build(...)
  call s:build()
endfunction

function! spacevim#vim#cscope#UpdateDB()
  if filereadable('cscope.out')
    call s:build()
  endif
endfunction

function! s:find(type)
  let l:opt = {
        \ 'symbol':'s', 'global': 'g', 'calls': 'c', 'text': 't', 'egrep': 'e', 'called':'d',
        \ }
  let l:cword = expand("<cword>")
  for [l:key, l:value] in items(l:opt)
    if l:key == a:type
      try
        exe ":cs find ".l:value." ".l:cword
        return
      catch /^Vim\%((\a\+)\)\=:E259/
        call spacevim#util#err('cscope trys finding <'.l:key.'>, but no matches for '.l:cword)
      endtry
    endif
  endfor
  if a:type == 'file'
    :cs find f <cfile>
  elseif a:type == 'includes'
    :cs find i <cfile>
  endif
endfunction

function! spacevim#vim#cscope#Find(type)
  if s:is_building
    call spacevim#util#info('still building the cscope database, please wait for seconds...')
    return
  endif
  try
    call s:find(a:type)
  catch /E567: no cscope connections/
    call spacevim#util#info('no cscope connections, try building ....')
    call s:build()
    let s:find_after_build = a:type
  endtry
endfunction
