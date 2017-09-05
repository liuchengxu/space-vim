"""""""""""""""""""""""""""""""""""""""""""""""""""
"    Basic tools
"""""""""""""""""""""""""""""""""""""""""""""""""""
function! spacevim#util#err(msg)
  echohl ErrorMsg
  echom '[space-vim] '.a:msg
  echohl None
endfunction

function! spacevim#util#warn(cmd, msg)
  echohl WarningMsg
  echom '[space-vim] '.a:msg
  echohl None
endfunction

" argument plugin is the vim plugin's name
function! spacevim#util#IsDir(plugin) abort
  return isdirectory(expand(g:my_plug_home.a:plugin)) ? 1 : 0
endfunction

function! spacevim#util#LayerLoaded(layer) abort
    return index(g:layers_loaded, a:layer) > -1 ? 1 : 0
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""
"    Utilities
"""""""""""""""""""""""""""""""""""""""""""""""""""
function! spacevim#util#ToggleCursorColumn()
  if &cursorcolumn
    setlocal nocursorcolumn
  else
    setlocal cursorcolumn
  endif
endfunction

function! spacevim#util#ToggleColorColumn()
  if &colorcolumn
    setlocal colorcolumn=
  else
    setlocal colorcolumn=80
  endif
endfunction

function! spacevim#util#CompileAndRun()
  let l:cmd = {
        \ 'c': "gcc % -o %<; time ./%<",
        \ 'sh': "time bash %",
        \ 'go': "go run %",
        \ 'cpp': "g++ -std=c++11 % -o %<; time ./%<",
        \ 'ruby': "time ruby %",
        \ 'java': "javac %; time java %<",
        \ 'rust': "rustc % -o %<; time ./%<",
        \ 'python': "time python %",
        \}
  let l:ft = &filetype
  if has_key(l:cmd, l:ft)
    exec 'w'
    exec "AsyncRun! ".l:cmd[l:ft]
  else
    call spacevim#util#err("spacevim#util#CompileAndRun not supported in current filetype!")
  endif
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
