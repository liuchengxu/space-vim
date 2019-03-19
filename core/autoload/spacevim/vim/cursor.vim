" Credit: ALE, Snippets from ALE
" Also see http://vim.wikia.com/wiki/Get_shortened_messages_from_using_echomsg
function! spacevim#vim#cursor#TruncatedEcho(msg) abort
  let l:msg = a:msg
  " Change tabs to spaces.
  let l:msg = substitute(l:msg, "\t", ' ', 'g')
  " Remove any newlines in the message.
  let l:msg = substitute(l:msg, "\n", '', 'g')
  " We need to remember the setting for shortmess and reset it again.
  let l:shortmess_options = &l:shortmess
  try
      let l:cursor_position = getpos('.')

      " The message is truncated and saved to the history.
      setlocal shortmess+=T
      try
          exec "norm! :echomsg l:msg\n"
      catch /^Vim\%((\a\+)\)\=:E523/
          " Fallback into manual truncate (ale #1987)
          let l:winwidth = winwidth(0)
          if l:winwidth < strdisplaywidth(l:msg)
              " Truncate msg longer than window width with trailing '...'
              let l:msg = l:msg[:l:winwidth - 4] . '...'
          endif
          exec 'echomsg l:msg'
      endtry

      " Reset the cursor position if we moved off the end of the line.
      " Using :norm and :echomsg can move the cursor off the end of the
      " line.
      " Note: patch 8.1.0998 https://github.com/vim/vim/commit/19a66858a5e3fedadc371321834507c34e2dfb18
      if l:cursor_position != getpos('.')
          call setpos('.', l:cursor_position)
      endif
  finally
      let &l:shortmess = l:shortmess_options
  endtry
endfunction
