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

function! spacevim#util#load(layer) abort
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

let s:hidden_all = 0
function! spacevim#util#ToggleHiddleAll()
  if s:hidden_all == 0
    let s:hidden_all = 1
    setlocal noshowmode noruler noshowcmd laststatus=0 cmdheight=1
  else
    let s:hidden_all = 0
    setlocal showmode ruler showcmd laststatus=2 cmdheight=1
  endif
endfunction

function! spacevim#util#RootDirectory()
  if exists('*FindRootDirectory')
    let root_dir = FindRootDirectory()
  else
    let git_dir = system('git rev-parse --git-dir')
    if !v:shell_error
      let root_dir = substitute(fnamemodify(git_dir, ':p:h'), ' ', '\\ ', 'g')
    else
      let root_dir = ''
    endif
  endif
  return root_dir == '' ? getcwd() : root_dir
endfunction

function! spacevim#util#ExpandSnippetOrCarriageReturn()
  if exists("*UltiSnips#ExpandSnippet")
    if get(g:, 'ulti_expand_res', 0) > 0
      return UltiSnips#ExpandSnippet()
    endif
  endif
  return "\<c-y>\<cr>"
endfunction
