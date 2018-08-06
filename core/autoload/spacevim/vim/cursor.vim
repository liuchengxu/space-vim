" Snippets from ALE
" Credit: ALE
function! spacevim#vim#cursor#TruncatedEcho(msg) abort
  " We need to remember the setting for shortmess and reset it again.
  let l:shortmess_options = &l:shortmess
  try
      let l:cursor_position = getcurpos()

      " The message is truncated and saved to the history.
      setlocal shortmess+=T
      exec "norm! :echomsg a:msg\n"

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
