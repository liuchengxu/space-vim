" Define prefix dictionary
let g:spacevim#plug#which_key#leader =  get(g:, 'spacevim#plug#which_key#leader', {})

for s:i in range(1, 9)
  let g:spacevim#plug#which_key#leader[s:i] = [ s:i.'wincmd w', 'windows '.s:i ]
endfor

let g:spacevim#plug#which_key#leader['?'] = [ 'Maps', 'show keybindings' ]
let g:spacevim#plug#which_key#leader[';'] = [ '<Plug>NERDCommenterComment','Commenter']
let g:spacevim#plug#which_key#leader[' '] = [ '<Plug>easymotion-prefix', 'easymotion-prefix' ]
let g:spacevim#plug#which_key#leader['a'] = {
      \ 'name' : '+align',
      \ }
let g:spacevim#plug#which_key#leader['b'] = {
      \ 'name' : '+buffer' ,
      \ '1' : ['b1'        , 'buffer 1']        ,
      \ '2' : ['b2'        , 'buffer 2']        ,
      \ '3' : ['b3'        , 'buffer 3']        ,
      \ '4' : ['b4'        , 'buffer 4']        ,
      \ '5' : ['b5'        , 'buffer 5']        ,
      \ '6' : ['b6'        , 'buffer 6']        ,
      \ '7' : ['b7'        , 'buffer 7']        ,
      \ '8' : ['b8'        , 'buffer 8']        ,
      \ '9' : ['b9'        , 'buffer 9']        ,
      \ 'd' : ['bd'        , 'delete-buffer']   ,
      \ 'f' : ['bfirst'    , 'first-buffer']    ,
      \ 'h' : ['Startify'  , 'home-buffer']     ,
      \ 'k' : ['bw'        , 'kill-buffer']     ,
      \ 'l' : ['blast'     , 'last-buffer']     ,
      \ 'n' : ['bnext'     , 'next-buffer']     ,
      \ 'p' : ['bprevious' , 'previous-buffer'] ,
      \ 'b' : ['Buffers'   , 'fzf-buffer']      ,
      \ '?' : ['Buffers'   , 'fzf-buffer']      ,
      \ }
if spacevim#load('cscope')
  let g:spacevim#plug#which_key#leader['c'] = {
        \ 'name' : '+cscope'                                 ,
        \ 's' : ['spacevim#vim#cscope#Find("symbol")'   , 'find-this-symbol']                       ,
        \ 'g' : ['spacevim#vim#cscope#Find("global")'   , 'global-definition']                      ,
        \ 'c' : ['spacevim#vim#cscope#Find("calls")'    , 'find-functions-calling-this-function']   ,
        \ 't' : ['spacevim#vim#cscope#Find("text")'     , 'text']                                   ,
        \ 'e' : ['spacevim#vim#cscope#Find("egrep")'    , 'egrep']                                  ,
        \ 'f' : ['spacevim#vim#cscope#Find("file")'     , 'find-this-file']                         ,
        \ 'i' : ['spacevim#vim#cscope#Find("includes")' , 'find-files-#include-this-file']          ,
        \ 'd' : ['spacevim#vim#cscope#Find("called")'   , 'find-functions-called-by-this-function'] ,
        \ }
endif
let g:spacevim#plug#which_key#leader['d'] = [ '<C-d>', 'scroll-down' ]
let g:spacevim#plug#which_key#leader['e'] = {
      \ 'name' : '+errors'                              ,
      \ 'n' : ['<Plug>(ale_next)'     , 'next-error']     ,
      \ 'p' : ['<Plug>(ale_previous)' , 'previous-error'] ,
      \ }
let g:spacevim#plug#which_key#leader['f'] = {
      \ 'name' : '+find/files/fold' ,
      \ '0' : ['set foldlevel=0'    , '0-fold-level']                    ,
      \ '1' : ['set foldlevel=1'    , '1-fold-level']                    ,
      \ '2' : ['set foldlevel=2'    , '2-fold-level']                    ,
      \ '3' : ['set foldlevel=3'    , '3-fold-level']                    ,
      \ '4' : ['set foldlevel=4'    , '4-fold-level']                    ,
      \ '5' : ['set foldlevel=5'    , '5-fold-level']                    ,
      \ '6' : ['set foldlevel=6'    , '6-fold-level']                    ,
      \ '7' : ['set foldlevel=7'    , '7-fold-level']                    ,
      \ '8' : ['set foldlevel=8'    , '8-fold-level']                    ,
      \ '9' : ['set foldlevel=9'    , '9-fold-level']                    ,
      \ 'b' : ['BLines'             , 'fzf-find-current-buffer']         ,
      \ 'd' : ['NERDTreeFind'       , 'find-current-buffer-in-NERDTree'] ,
      \ 'f' : ['Files ~'            , 'files-in-home-direcotry']         ,
      \ 's' : ['save'               , 'save-file']                       ,
      \ 't' : ['NERDTreeToggle'     , 'toggle-NERDTree']                 ,
      \ '?' : ['Files'              , 'files-in-current-direcotry']      ,
      \ 'R' : ['source $MYVIMRC'    , 'reload-vimrc']                    ,
      \ }
let g:spacevim#plug#which_key#leader['g'] = {
      \ 'name' : '+git/version-control' ,
      \ 'b' : ['Gblame'                 , 'fugitive-blame']             ,
      \ 'c' : ['BCommits'               , 'commits-for-current-buffer'] ,
      \ 'C' : ['Gcommit'                , 'fugitive-commit']            ,
      \ 'd' : ['Gdiff'                  , 'fugitive-diff']              ,
      \ 'e' : ['Gedit'                  , 'fugitive-edit']              ,
      \ 'l' : ['Glog'                   , 'fugitive-log']               ,
      \ 'r' : ['Gread'                  , 'fugitive-read']              ,
      \ 's' : ['Gstatus'                , 'fugitive-status']            ,
      \ 'w' : ['Gwrite'                 , 'fugitive-write']             ,
      \ 'p' : ['Git push'               , 'fugitive-push']              ,
      \ 'y' : ['Goyo'                   , 'goyo-mode']                  ,
      \ }
let g:spacevim#plug#which_key#leader['h'] = {
      \ 'name' : '+help',
      \ }
let g:spacevim#plug#which_key#leader['j'] = {
      \ 'name' : '+jump'                                           ,
      \ 'j' : ['<Plug>(easymotion-overwin-f)'    , 'easymotion-goto-char']       ,
      \ 'J' : ['<Plug>(easymotion-overwin-f2)'   , 'easymotion-goto-char-2']     ,
      \ 'l' : ['<Plug>(easymotion-overwin-line)' , 'jump-linewise']              ,
      \ 'w' : ['<Plug>(easymotion-overwin-w)'    , 'jump-to-word-bidirectional'] ,
      \ 'f' : ['<Plug>(easymotion-prefix)w'      , 'jump-forward-wordwise']      ,
      \ 'b' : ['<Plug>(easymotion-prefix)b'      , 'jump-backword-wordwise']     ,
      \ }
let g:spacevim#plug#which_key#leader['l'] = {
      \ 'name' : '+lsp'                                            ,
      \ 'a' : ['LanguageClient#textDocument_codeAction()'     , 'code-action']      ,
      \ 'c' : ['LanguageClient_contextMenu()'                 , 'context-menu']      ,
      \ 'd' : ['LanguageClient#textDocument_definition()'     , 'definition']       ,
      \ 'f' : ['LanguageClient#textDocument_formatting()'     , 'formatting']       ,
      \ 'h' : ['LanguageClient#textDocument_hover()'          , 'hover']            ,
      \ 'i' : ['LanguageClient#textDocument_implementation('  , 'implementation']   ,
      \ 'r' : ['LanguageClient#textDocument_references()'     , 'references']       ,
      \ 'R' : ['LanguageClient#textDocument_rename()'         , 'rename']           ,
      \ 's' : ['LanguageClient#textDocument_documentSymbol()' , 'document-symbol']  ,
      \ 'S' : ['LanguageClient#workspace_symbol()'            , 'workspace-symbol'] ,
      \ 't' : ['LanguageClient#textDocument_typeDefinition()' , 'type-definition']  ,
      \ }
let g:spacevim#plug#which_key#leader['p'] = {
      \ 'name' : '+projects'                                ,
      \ 'f' : ['spacevim#plug#fzf#FindFileInProject()' , 'find-file-in-project']  ,
      \ 's' : ['Rag'                                        , 'search-in-project']     ,
      \ 'w' : ['spacevim#plug#fzf#SearchCword()'       , 'find-cword-in-project'] ,
      \ 'W' : ['spacevim#plug#fzf#SearchBcword()'      , 'find-cword-in-current-buffer']
      \ }
let g:spacevim#plug#which_key#leader['q'] = [ 'q', 'quit' ]
let g:spacevim#plug#which_key#leader['Q'] = [ 'qa!', 'quit-without-saving' ]
let g:spacevim#plug#which_key#leader['s'] = {
      \ 'name' : '+search/show'  ,
      \ 'c' : ['nohlsearch' , 'search-clear-highlight'],
      \ 'h' : ['spacevim#util#SyntaxHiGroup()', 'show-highlight-group']
      \ }
let g:spacevim#plug#which_key#leader['t'] = {
      \ 'name' : '+toggle'                               ,
      \ 'g' : ['GitGutterToggle'                         , 'gitgutter']     ,
      \ 'i' : ['IndentGuidesToggle'                      , 'indent-guide']  ,
      \ 'p' : ['setlocal paste!'                         , 'paste-mode']    ,
      \ 's' : ['SyntasticToggleMode'                     , 'syntastic']     ,
      \ 't' : ['TagbarToggle'                            , 'tagbar']        ,
      \ 'c' : ['spacevim#vim#toggle#CursorColumn()' , 'cursor-column'] ,
      \ 'C' : ['spacevim#vim#toggle#ColorColumn()'  , 'color-column']  ,
      \ }
let g:spacevim#plug#which_key#leader['u'] = [ '<C-u>', 'scroll-up' ]

let g:spacevim#plug#which_key#leader['w'] = {
      \ 'name' : '+windows'                          ,
      \ 'w' : ['<C-W>w'  , 'other-window']          ,
      \ 'd' : ['<C-W>c'  , 'delete-window']         ,
      \ '-' : ['<C-W>s' , 'split-window-below']    ,
      \ '|' : ['<C-W>v' , 'split-window-right']    ,
      \ '2' : ['<C-W>v' , 'layout-double-columns'] ,
      \ 'h' : ['<C-W>h'  , 'window-left']           ,
      \ 'j' : ['<C-W>j'  , 'window-below']          ,
      \ 'l' : ['<C-W>l'  , 'window-right']          ,
      \ 'k' : ['<C-W>k'  , 'window-up']             ,
      \ 'H' : ['<C-W>5<'  , 'expand-window-left']    ,
      \ 'J' : ['resize +5'  , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'  , 'expand-window-right']   ,
      \ 'K' : ['resize -5'  , 'expand-window-up']      ,
      \ '=' : ['<C-W>='  , 'balance-window']        ,
      \ 's' : ['<C-W>s' , 'split-window-below']    ,
      \ 'v' : ['<C-W>v' , 'split-window-below']    ,
      \ '?' : ['Windows'                             , 'fzf-window']            ,
      \ }

let g:spacevim#plug#which_key#leader['x'] = {
      \ 'name' : '+text'                             ,
      \ 'a' : ['<Plug>(EasyAlign)' , 'easy-align']                 ,
      \ 'd' : ['StripWhitespace'                     , 'delete-trailing-whitespace'] ,
      \ }
