" opts: dict, {'cmd':, 'cwd':}
function! spacevim#vim#term#Open(opts) abort
  execute 'belowright' '10new' '+setl\ buftype=nofile'
  setlocal buftype=nofile winfixheight norelativenumber nonumber bufhidden=wipe
  let cmd = get(a:opts, 'cmd', '')
  if empty(cmd) | return | endif
  let cwd = get(a:opts, 'cwd', getcwd())
  let bufnr = bufnr('%')
  if has('nvim')
    call termopen(cmd, {
          \ 'cwd': cwd,
          \})
  else
    execute 'lcd' cwd
    call term_start(cmd, {
          \ 'curwin': 1,
          \})
  endif
  wincmd p
  return bufnr
endfunction

" Run cmd in terminal buffer
" e.g., call spacevim#vim#term#Run('git', 'status')
function! spacevim#vim#term#Run(...) abort
  " a:000 ['git', 'status']
  call spacevim#vim#term#Open({'cmd': a:000})
endfunction
