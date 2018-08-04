function! s:buf_total_num()
  return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunction

function! s:file_size(f)
  let l:size = getfsize(expand(a:f))
  if l:size == 0 || l:size == -1 || l:size == -2
    return ''
  endif
  if l:size < 1024
    return l:size.'bytes'
  elseif l:size < 1024*1024
    return printf('%.1f', l:size/1024.0).'K'
  elseif l:size < 1024*1024*1024
    return printf('%.1f', l:size/1024.0/1024.0) . 'M'
  else
    return printf('%.1f', l:size/1024.0/1024.0/1024.0) . 'G'
  endif
endfunction

function! spacevim#vim#file#CtrlG() abort
  redir => file
  :silent f!
  redir END
  let l:msg = join([file[2:], 'Cursor '.line('.').':'.col('.'), s:file_size(@%), 'TOT:'.s:buf_total_num(), '['.&ft.']'], ' ')
  " snippets from ALE
  " credit: ALE
  " We need to remember the setting for shortmess and reset it again.
  let l:shortmess_options = &l:shortmess
  try
      let l:cursor_position = getcurpos()

      " The message is truncated and saved to the history.
      setlocal shortmess+=T
      exec "norm! :echomsg l:msg\n"

      " Reset the cursor position if we moved off the end of the line.
      " Using :norm and :echomsg can move the cursor off the end of the
      " line.
      if l:cursor_position != getcurpos()
          call setpos('.', l:cursor_position)
      endif
  finally
      let &l:shortmess = l:shortmess_options
  endtry
endfunction
