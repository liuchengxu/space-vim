let s:grep = {}

if executable('rg')
  let s:grep.prg = 'rg -H --no-heading --vimgrep'
  let s:grep.format = '%f:%l:%c:%m'
elseif executable('ag')
  let s:grep.prg = 'ag --nogroup --nocolor --column'
  let s:grep.format = '%f:%l:%c:%m,%f:%l:%m'
else
  let s:grep.prg = 'grep -rn $* *'
  let s:grep.format = '%f:%l:%m'
endif

" Incomplete, I'm not satisfied with buffer number of quickfix
function! spacevim#vim#grep#Grep(query)
  let grepprg = &l:grepprg
  let grepformat = &l:grepformat
  " https://github.com/mileszs/ack.vim/issues/18
  let shellpipe = &l:shellpipe
  let &l:shellpipe = '>'
  let &l:grepprg = s:grep.prg
  let &l:grepformat = s:grep.format
  " https://github.com/mileszs/ack.vim/issues/5
  execute 'silent! grep! '.shellescape(fnameescape(a:query))
  let &l:grepprg = grepprg
  let &l:grepformat = grepformat
  let &l:shellpipe = shellpipe
  redraw!
endfunction
