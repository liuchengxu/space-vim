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

function! spacevim#util#info(msg)
  echom '[space-vim] '.a:msg
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
        \ 'c'      : "gcc % -o %<; time ./%<",
        \ 'sh'     : "time bash %",
        \ 'go'     : "go run %",
        \ 'cpp'    : "g++ -std=c++11 % -o %<; time ./%<",
        \ 'ruby'   : "time ruby %",
        \ 'java'   : "javac %; time java %<",
        \ 'rust'   : "rustc % -o %<; time ./%<",
        \ 'python' : "time python %",
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

" [DEPRECATED] ALE statusline integration
function! spacevim#util#ALEGetError()
  let l:res = ale#statusline#Status()
  if l:res ==# 'OK'
    return ''
  else
    let l:e_w = split(l:res)
    if len(l:e_w) == 2 || match(l:e_w, 'E') > -1
      return ' •' . matchstr(l:e_w[0], '\d\+') .' '
    endif
  endif
endfunction

function! spacevim#util#ALEGetWarning()
  let l:res = ale#statusline#Status()
  if l:res ==# 'OK'
    return ''
  else
    let l:e_w = split(l:res)
    if len(l:e_w) == 2
      return ' •' . matchstr(l:e_w[1], '\d\+')
    elseif match(l:e_w, 'W') > -1
      return ' •' . matchstr(l:e_w[0], '\d\+')
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

function! spacevim#util#GetNvimVersion()
    redir => s
    silent! version
    redir END
    return matchstr(s, 'NVIM v\zs[^\n]*')
endfunction
