"""""""""""""""""""""""""""""""""""""""""""""""""""
"    Basic tools
"""""""""""""""""""""""""""""""""""""""""""""""""""
function! spacevim#util#err(msg)
  echohl ErrorMsg
  call spacevim#vim#cursor#TruncatedEcho('[space-vim] '.a:msg)
  echohl None
endfunction

function! spacevim#util#warn(msg)
  echohl WarningMsg
  call spacevim#vim#cursor#TruncatedEcho('[space-vim] '.a:msg)
  echohl None
endfunction

function! spacevim#util#info(msg)
  call spacevim#vim#cursor#TruncatedEcho('[space-vim] '.a:msg)
endfunction

" argument plugin is the vim plugin's name
function! spacevim#util#IsDir(plugin) abort
  return isdirectory(expand(g:my_plug_home.a:plugin)) ? 1 : 0
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""
"    Utilities
"""""""""""""""""""""""""""""""""""""""""""""""""""
function! spacevim#util#Join(...) abort
  return join(a:000, '')
endfunction

function! spacevim#util#Runtimepath()
  for path in split(&runtimepath, ',')
    echo path
  endfor
endfunction

" http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
function! spacevim#util#SyntaxHiGroup()
  echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
  \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
  \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
endfunction

function! spacevim#util#HiOverLength(width)
  highlight OverLength ctermbg=133 ctermfg=254 cterm=bold guibg=#592929
  exec 'match OverLength /\%' . string(a:width+1) . 'v.*/'
endfunction

" http://vim.wikia.com/wiki/Jumping_to_previously_visited_locations
function! spacevim#util#GotoJump()
  jumps
  let l:j = input("Please select your jump: ")
  if l:j != ''
    let l:pattern = '\v\c^\+'
    if l:j =~ l:pattern
      let l:j = substitute(l:j, l:pattern, '', 'g')
      execute "normal " . l:j . "\<C-I>"
    else
      execute "normal " . l:j . "\<C-O>"
    endif
  endif
endfunction

" https://www.reddit.com/r/vim/comments/79q6aq/vim_tip_keybinding_for_opening_plugin_homepage/
" visiting the GitHub page of the plugin defined on the current line
function! spacevim#util#OpenPluginHomepage() abort
  let line = getline(".")
  let $BROWSER = 'open'

  " Matches for instance Plug 'tpope/surround' -> tpope/surround
  " Non-greedy match in order to not capture trailing comments
  let plugin_name = '\w\+ \([''"]\)\(.\{-}\)\1'
  let repository = matchlist(line, plugin_name)[2]

  " Open the corresponding GitHub homepage with $BROWSER
  " You need to set the BROWSER environment variable in order for this to work
  " For MacOS, you can set the following for opening it in your default
  " browser: 'export BROWSER=open'
  silent exec "!$BROWSER https://github.com/".repository
endfunction

function! s:is_in_git_repo() abort
  let git_dir = system('git rev-parse --git-dir')
  return v:shell_error ? '' : substitute(fnamemodify(git_dir, ':p:h'), ' ', '\\ ', 'g')
endfunction

function! spacevim#util#RootDirectory() abort
  let root_dir = s:is_in_git_repo()
  if root_dir != ''
    return root_dir
  endif
  if exists('*FindRootDirectory')
    let root_dir = FindRootDirectory()
  endif
  return root_dir == '' ? getcwd() : root_dir
endfunction

function! spacevim#util#VisualSelection() abort
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

" Get all lines in the buffer as a a list. Snippet from vim-go
function! spacevim#util#GetLines() abort
  let buf = getline(1, '$')
  if &encoding != 'utf-8'
    let buf = map(buf, 'iconv(v:val, &encoding, "utf-8")')
  endif
  if &l:fileformat == 'dos'
    " XXX: line2byte() depend on 'fileformat' option.
    " so if fileformat is 'dos', 'buf' must include '\r'.
    let buf = map(buf, 'v:val."\r"')
  endif
  return buf
endfunction

function! spacevim#util#Getfsize(fname) abort
  let l:size = getfsize(a:fname)
  if l:size == 0 || l:size == -1 || l:size == -2
    return ''
  endif
  if l:size < 1024
    let size = l:size.'bytes'
  elseif l:size < 1024*1024
    let size = printf('%.1f', l:size/1024.0).'k'
  elseif l:size < 1024*1024*1024
    let size = printf('%.1f', l:size/1024.0/1024.0) . 'm'
  else
    let size = printf('%.1f', l:size/1024.0/1024.0/1024.0) . 'g'
  endif
  return size
endfunction

function! spacevim#util#FloatingWin() abort
  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  let col_offset = &columns / 6

  let opts = {
        \ 'relative': 'editor',
        \ 'row': height * 0.3,
        \ 'col': col + col_offset,
        \ 'width': width * 2 / 3,
        \ 'height': height / 2
        \ }

  let buf = nvim_create_buf(v:false, v:true)

  let win = nvim_open_win(buf, v:true, opts)

  call setwinvar(win, '&winhl', 'Normal:Pmenu')

  setlocal
        \ buftype=nofile
        \ nobuflisted
        \ bufhidden=hide
        \ nonumber
        \ norelativenumber
        \ signcolumn=no
endfunction

function! spacevim#util#TryFloatingOr()
  if exists('*nvim_open_win')
    call spacevim#util#FloatingWin()
  else
    botright 15 new
  endif
endfunction

function! spacevim#util#PathSep() abort
  return g:spacevim.os.windows ? '\' : '/'
endfunction

" command! ProfileStart call spacevim#util#ProfileStart()
" command! ProfileStop  call spacevim#util#ProfileStop()
"
" Find why vim is slow?
" 1. :ProfileStart
" 2. do the slow operation.
" 3. :ProfileStop
" 4. open profile.log
function! spacevim#util#ProfileStart() abort
  profile start profile.log
  profile func *
  profile file *
  set verbosefile=verbose.log
  set verbose=9
endfunction

function! spacevim#util#ProfileStop() abort
  profile pause
  noautocmd wqa!
endfunction

" https://vi.stackexchange.com/questions/8534/make-cnext-and-cprevious-loop-back-to-the-begining
function! spacevim#util#CycleQuickfix(action, fallback) abort
  try
    execute a:action
  catch
    execute a:fallback
  finally
    normal! zz
  endtry
endfunction
