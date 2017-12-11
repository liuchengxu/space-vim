let s:lines=&lines
let s:columns=&columns

function! s:enter_full_screen()
  setlocal lines=999 columns=999
  setlocal fullscreen
endfunction

function! s:leave_full_screen()
  let &lines=s:lines
  let &columns=s:columns
  setlocal nofullscreen
endfunction

function! spacevim#vim#gui#ToggleFullScreen()
  if &fullscreen
    call s:leave_full_screen()
  else
    call s:enter_full_screen()
  endif
endfunction

" http://vim.wikia.com/wiki/Restore_screen_size_and_position
function! s:screen_filename()
  if has('amiga')
    return "s:.vimsize"
  elseif has('win32')
    return $HOME.'\_vimsize'
  else
    return $HOME.'/.vimsize'
  endif
endfunction

function! spacevim#vim#gui#ScreenRestore()
  " Restore window size (columns and lines) and position
  " from values stored in vimsize file.
  " Must set font first so columns and lines are based on font size.
  let f = s:screen_filename()
  if has("gui_running") && g:screen_size_restore_pos && filereadable(f)
    let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
    for line in readfile(f)
      let sizepos = split(line)
      if len(sizepos) == 5 && sizepos[0] == vim_instance
        silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
        silent! execute "winpos ".sizepos[3]." ".sizepos[4]
        return
      endif
    endfor
  endif
endfunction

function! spacevim#vim#gui#ScreenSave()
  " Save window size and position.
  if has("gui_running") && g:screen_size_restore_pos
    let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
    let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
          \ (getwinposx()<0?0:getwinposx()) . ' ' .
          \ (getwinposy()<0?0:getwinposy())
    let f = s:screen_filename()
    if filereadable(f)
      let lines = readfile(f)
      call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
      call add(lines, data)
    else
      let lines = [data]
    endif
    call writefile(lines, f)
  endif
endfunction
