function! spacevim#lang#python#run()
  let l:cmd = has_key(g:plugs, 'asyncrun.vim') ? 'AsyncRun!' : '!'
  let l:exe = spacevim#lang#util#InferExecutable()
  let l:py = l:exe != '' ? l:exe : get(g:, 'spacevim_python_run', 'python')
  let l:fname = shellescape(@%, 1)
  execute join([l:cmd, l:py, l:fname], ' ')
endfunction

function! spacevim#lang#python#stop()
  execute 'AsyncStop!'
endfunction

" Refer to https://github.com/mindriot101/vim-yapf
function! s:yapf()
  let cmd = "yapf"
  let cur_line = line('.')
  " save current cursor position
  let cur_cursor = getpos(".")
  silent execute "0,$!" . cmd
  " restore cursor
  call setpos('.', cur_cursor)
  if v:shell_error != 0
      " Shell command failed, so open a new buffer with error text
      execute 'normal! gg"ayG'
      silent undo
      execute 'normal! ' . cur_line . 'G'
      " restore cursor position
      call setpos('.', cur_cursor)
      silent new
      silent put a
  else
    call spacevim#util#info('Formatted successfully')
  end
endfunction

function! spacevim#lang#python#fmt()
  if executable('yapf')
    call s:yapf()
  else
    call spacevim#util#err('yapf is unavailable, please install it first.')
  endif
endfunction
