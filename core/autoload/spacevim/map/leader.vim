" Define prefix dictionary
let g:spacevim#map#leader#desc =  get(g:, 'spacevim#map#leader#desc', {})
let g:spacevim#map#leader#desc['name'] =  'space-vim root'

for s:i in range(1, 9)
  let g:spacevim#map#leader#desc[s:i] = 'window-'.s:i
endfor
unlet s:i

let g:spacevim#map#leader#desc['?'] = [ 'Maps', 'show-keybindings' ]
let g:spacevim#map#leader#desc[';'] = [ '<Plug>NERDCommenterToggle','commenter' ]
let g:spacevim#map#leader#desc[' '] = {
      \ 'name': '+tab' ,
      \ '1' : 'tab-1'  ,
      \ '2' : 'tab-2'  ,
      \ '3' : 'tab-3'  ,
      \ '4' : 'tab-4'  ,
      \ '5' : 'tab-5'  ,
      \ '6' : 'tab-6'  ,
      \ '7' : 'tab-7'  ,
      \ '8' : 'tab-8'  ,
      \ '9' : 'tab-9'  ,
      \ 'c' : ['tabclose', 'close-current-tab'],
      \ }

let g:spacevim#map#leader#desc['a'] = {
      \ 'name' : '+align',
      \ }

let g:spacevim#map#leader#desc['b'] = {
      \ 'name' : '+buffer'       ,
      \ '1' :  'buffer-1'        ,
      \ '2' :  'buffer-2'        ,
      \ '3' :  'buffer-3'        ,
      \ '4' :  'buffer-4'        ,
      \ '5' :  'buffer-5'        ,
      \ '6' :  'buffer-6'        ,
      \ '7' :  'buffer-7'        ,
      \ '8' :  'buffer-8'        ,
      \ '9' :  'buffer-9'        ,
      \ 'd' :  'delete-buffer'   ,
      \ 'f' :  'first-buffer'    ,
      \ 'h' :  'home-buffer'     ,
      \ 'k' :  'kill-buffer'     ,
      \ 'l' :  'last-buffer'     ,
      \ 'n' :  'next-buffer'     ,
      \ 'p' :  'previous-buffer' ,
      \ 'b' :  'fzf-buffer'      ,
      \ '?' :  'fzf-buffer'      ,
      \ }

let g:spacevim#map#leader#desc['c'] = {
      \ 'name' : '+cscope'                            ,
      \ 's' : ['spacevim#vim#cscope#Find("symbol")'   , 'find-this-symbol']                       ,
      \ 'g' : ['spacevim#vim#cscope#Find("global")'   , 'global-definition']                      ,
      \ 'c' : ['spacevim#vim#cscope#Find("calls")'    , 'find-functions-calling-this-function']   ,
      \ 't' : ['spacevim#vim#cscope#Find("text")'     , 'text']                                   ,
      \ 'e' : ['spacevim#vim#cscope#Find("egrep")'    , 'egrep']                                  ,
      \ 'f' : ['spacevim#vim#cscope#Find("file")'     , 'find-this-file']                         ,
      \ 'i' : ['spacevim#vim#cscope#Find("includes")' , 'find-files-#include-this-file']          ,
      \ 'd' : ['spacevim#vim#cscope#Find("called")'   , 'find-functions-called-by-this-function'] ,
      \ }

let g:spacevim#map#leader#desc['d'] = 'scroll-down'

let g:spacevim#map#leader#desc['e'] = {
      \ 'name' : '+errors'     ,
      \ 'n' : 'next-error'     ,
      \ 'p' : 'previous-error' ,
      \ }

let g:spacevim#map#leader#desc['f'] = {
      \ 'name' : '+find/files/fold'             ,
      \ '0' : '0-fold-level'                    ,
      \ '1' : '1-fold-level'                    ,
      \ '2' : '2-fold-level'                    ,
      \ '3' : '3-fold-level'                    ,
      \ '4' : '4-fold-level'                    ,
      \ '5' : '5-fold-level'                    ,
      \ '6' : '6-fold-level'                    ,
      \ '7' : '7-fold-level'                    ,
      \ '8' : '8-fold-level'                    ,
      \ '9' : '9-fold-level'                    ,
      \ 'd' : 'find-current-buffer-in-NERDTree' ,
      \ 'f' : 'files-in-home-direcotry'         ,
      \ 's' : 'save-file'                       ,
      \ 't' : 'toggle-NERDTree'                 ,
      \ '?' : 'files-in-current-direcotry'      ,
      \ 'R' : 'reload-vimrc'                    ,
      \ 'b' : ['BLines'                         , 'fzf-find-current-buffer'] ,
      \ }

let g:spacevim#map#leader#desc['g'] = {
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

let g:spacevim#map#leader#desc['h'] = {
      \ 'name' : '+help',
      \ }

let g:spacevim#map#leader#desc['j'] = {
      \ 'name' : '+jump/json'                   ,
      \ 'j' : 'easymotion-goto-char'       ,
      \ 'J' : 'easymotion-goto-char-2'     ,
      \ 'l' : 'jump-linewise'              ,
      \ 'w' : 'jump-to-word-bidirectional' ,
      \ 'f' : 'jump-forward-wordwise'      ,
      \ 'b' : 'jump-backword-wordwise'     ,
      \ 'F' : ['execute line(".")."!python -m json.tool"', 'format-current-raw-oneline-json'],
      \ }

let g:spacevim#map#leader#desc['l'] = {
      \ 'name' : '+lsp'                               ,
      \ 'a' : ['spacevim#lang#util#CodeAction()'      , 'code-action']      ,
      \ 'c' : ['LanguageClient_contextMenu()'         , 'context-menu']     ,
      \ 'f' : ['spacevim#lang#util#Format()'          , 'formatting']       ,
      \ 'h' : ['LanguageClient#textDocument_hover()'  , 'hover']            ,
      \ 'r' : ['spacevim#lang#util#FindReferences()'  , 'references']       ,
      \ 'R' : ['spacevim#lang#util#Rename()'          , 'rename']           ,
      \ 's' : ['spacevim#lang#util#DocumentSymbol()'  , 'document-symbol']  ,
      \ 'S' : ['spacevim#lang#util#WorkspaceSymbol()' , 'workspace-symbol'] ,
      \ 'g' : {
        \ 'name': '+goto'                                       ,
        \ 'd' : ['spacevim#lang#util#Definition()'     , 'definition']      ,
        \ 't' : ['spacevim#lang#util#TypeDefinition()' , 'type-definition'] ,
        \ 'i' : ['spacevim#lang#util#Implementation()' , 'implementation']  ,
        \ }                                                     ,
      \ }

let g:spacevim#map#leader#desc['p'] = {
      \ 'name' : '+projects'                                ,
      \ 'f' : ['spacevim#plug#fzf#FindFileInProject()' , 'find-file-in-project']  ,
      \ 's' : ['Rag'                                        , 'search-in-project']     ,
      \ 'w' : ['spacevim#plug#fzf#SearchCword()'       , 'find-cword-in-project'] ,
      \ }

let g:spacevim#map#leader#desc['r'] = {
      \ 'c' : 'replace-current-word-in-current-file',
      \ }

let g:spacevim#map#leader#desc['q'] = [ 'q', 'quit' ]

let g:spacevim#map#leader#desc['Q'] = [ 'qa!', 'quit-without-saving' ]

let g:spacevim#map#leader#desc['s'] = {
      \ 'name' : '+search/show'                   ,
      \ 'c' : 'search-clear-highlight'            ,
      \ 'h' : ['spacevim#util#SyntaxHiGroup()'    , 'show-highlight-group']   ,
      \ 'b' : ['BLines'                           , 'search-in-buffer']       ,
      \ 'B' : ['spacevim#plug#fzf#SearchBcword()' , 'search-cword-in-buffer'] ,
      \ }

function! s:buftag() abort
  if exists(':BTags')
    BTags
  elseif exists(':LeaderfBufTag')
    LeaderfBufTag
  else
    echom "Not avaliable"
  endif
endfunction

let g:spacevim#map#leader#desc['t'] = {
      \ 'name' : '+toggle/tag'                          ,
      \ 'g' : ['spacevim#plug#toggle#Git()'         , 'git-status-indicator'] ,
      \ 'i' : ['IndentGuidesToggle'                 , 'indent-guide']         ,
      \ 'p' : ['setlocal paste!'                    , 'paste-mode']           ,
      \ 's' : ['SyntasticToggleMode'                , 'syntastic']            ,
      \ 'b' : [function('s:buftag')                   , 'tags-in-current-buffer'],
      \ 'T' : ['TagbarToggle'                       , 'tagbar']               ,
      \ 'c' : ['spacevim#vim#toggle#CursorColumn()' , 'cursor-column']        ,
      \ 'C' : ['spacevim#vim#toggle#ColorColumn()'  , 'color-column']         ,
      \ }

let g:spacevim#map#leader#desc['u'] = 'scroll-up'

let g:spacevim#map#leader#desc['w'] = {
      \ 'name' : '+windows'                       ,
      \ 'w' :  'other-window'                     ,
      \ 'd' :  'delete-window'                    ,
      \ '-' :  'split-window-below'               ,
      \ '|' :  'split-window-right'               ,
      \ '2' :  'layout-double-columns'            ,
      \ 'o' :  ['only', 'close-all-windows-except-current'] ,
      \ 'h' :  'window-left'                      ,
      \ 'j' :  'window-below'                     ,
      \ 'l' :  'window-right'                     ,
      \ 'k' :  'window-up'                        ,
      \ 'H' :  'expand-window-left'               ,
      \ 'J' :  'expand-window-below'              ,
      \ 'L' :  'expand-window-right'              ,
      \ 'K' :  'expand-window-up'                 ,
      \ '=' :  'balance-window'                   ,
      \ 's' :  'split-window-below'               ,
      \ 'v' :  'split-window-below'               ,
      \ '?' :  'fzf-window'                       ,
      \ }

let g:spacevim#map#leader#desc['x'] = {
      \ 'name' : '+text'           ,
      \ 'a' : ['<Plug>(EasyAlign)' , 'easy-align']                 ,
      \ 'd' : ['StripWhitespace'   , 'delete-trailing-whitespace'] ,
      \ }
