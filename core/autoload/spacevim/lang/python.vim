function! spacevim#lang#python#run()
  if has_key(g:plugs, 'asyncrun.vim')
    let l:cmd = 'AsyncRun!'
    call spacevim#vim#auto#AsyncRunStart()
  else
    let l:cmd = '!'
  endif
  let l:py = get(g:, 'spacevim_python_run', 'python')
  execute l:cmd.' '.l:py.' '.shellescape(@%, 1)
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
    else
      call spacevim#util#info('Formatted successfully')
    end
  else
    call spacevim#util#err('yapf is unavailable, please install it first.')
  endif
endfunction
