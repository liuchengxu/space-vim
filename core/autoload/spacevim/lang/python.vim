function! spacevim#lang#python#run()
  if has_key(g:plugs, 'asyncrun.vim')
    let l:cmd = 'AsyncRun!'
  else
    let l:cmd = '!'
  endif
  execute l:cmd.' python '.shellescape(@%, 1)
endfunction

function! spacevim#lang#python#stop()
  execute 'AsyncStop!'
endfunction

" Refer to https://github.com/mindriot101/vim-yapf
function! spacevim#lang#python#fmt()
  if executable('yapf')
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
    end
  else
    call spacevim#util#err('yapf is unavailable, please install it first.')<CR>
  endif
endfunction
