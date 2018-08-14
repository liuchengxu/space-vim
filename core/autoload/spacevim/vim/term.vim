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
  return bufnr
endfunction
