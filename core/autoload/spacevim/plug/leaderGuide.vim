" Define prefix dictionary
let g:spacevim#plug#leaderGuide#lmap =  {}

for s:i in range(1, 9)
    let g:spacevim#plug#leaderGuide#lmap[s:i] = [ s:i.'wincmd w', 'windows '.s:i ]
endfor
let g:spacevim#plug#leaderGuide#lmap['?'] = [ 'Maps', 'show keybindings' ]
let g:spacevim#plug#leaderGuide#lmap[';'] = [ 'call feedkeys("\<Plug>NERDCommenterComment")','Commenter']
let g:spacevim#plug#leaderGuide#lmap[' '] = [ 'call feedkeys("\<Plug>easymotion-prefix")', 'easymotion-prefix' ]
let g:spacevim#plug#leaderGuide#lmap['a'] = {
      \ 'name' : '+align',
      \ }
let g:spacevim#plug#leaderGuide#lmap['b'] = {
      \ 'name' : '+buffer',
      \ '1' : ['b1', 'buffer 1'],
      \ '2' : ['b2', 'buffer 2'],
      \ '3' : ['b3', 'buffer 3'],
      \ '4' : ['b4', 'buffer 4'],
      \ '5' : ['b5', 'buffer 5'],
      \ '6' : ['b6', 'buffer 6'],
      \ '7' : ['b7', 'buffer 7'],
      \ '8' : ['b8', 'buffer 8'],
      \ '9' : ['b9', 'buffer 9'],
      \ 'd' : ['bd', 'delete-buffer'],
      \ 'f' : ['bfirst', 'first-buffer'],
      \ 'h' : ['Startify', 'home-buffer'],
      \ 'k' : ['bw', 'kill-buffer'],
      \ 'l' : ['blast', 'last-buffer'],
      \ 'n' : ['bnext', 'next-buffer'],
      \ 'p' : ['bprevious', 'previous-buffer'],
      \ 'b' : ['Buffers', 'fzf-buffer'],
      \ '?' : ['Buffers', 'fzf-buffer'],
      \ }
if spacevim#load('cscope')
  let g:spacevim#plug#leaderGuide#lmap['c'] = {
        \ 'name' : '+cscope',
        \ 's' : ['call spacevim#vim#cscope#Find("symbol")', 'find-this-symbol'],
        \ 'g' : ['call spacevim#vim#cscope#Find("global")', 'global-definition'],
        \ 'c' : ['call spacevim#vim#cscope#Find("calls")', 'find-functions-calling-this-function'],
        \ 't' : ['call spacevim#vim#cscope#Find("text")', 'text'],
        \ 'e' : ['call spacevim#vim#cscope#Find("egrep")', 'egrep'],
        \ 'f' : ['call spacevim#vim#cscope#Find("file")', 'find-this-file'],
        \ 'i' : ['call spacevim#vim#cscope#Find("includes")', 'find-files-#include-this-file'],
        \ 'd' : ['call spacevim#vim#cscope#Find("called")', 'find-functions-called-by-this-function'],
        \ }
endif
let g:spacevim#plug#leaderGuide#lmap['d'] = [ 'call feedkeys("\<C-d>")', 'scroll-down' ]
let g:spacevim#plug#leaderGuide#lmap['e'] = {
      \ 'name' : '+errors',
      \ 'n' : ['call feedkeys("\<Plug>(ale_next)")', 'next-error'],
      \ 'p' : ['call feedkeys("\<Plug>(ale_previous)")', 'previous-error'],
      \ }
let g:spacevim#plug#leaderGuide#lmap['f'] = {
      \ 'name' : '+fold/files',
      \ }
let g:spacevim#plug#leaderGuide#lmap['g'] = {
      \ 'name' : '+git/version-control',
      \ 'b' : ['Gblame', 'fugitive-blame'],
      \ 'c' : ['Gcommit', 'fugitive-commit'],
      \ 'd' : ['Gdiff', 'fugitive-diff'],
      \ 'e' : ['Gedit', 'fugitive-edit'],
      \ 'l' : ['Glog', 'fugitive-log'],
      \ 'r' : ['Gread', 'fugitive-read'],
      \ 's' : ['Gstatus', 'fugitive-status'],
      \ 'w' : ['Gwrite', 'fugitive-write'],
      \ 'p' : ['Git push', 'fugitive-push'],
      \ 'y' : ['Goyo', 'goyo-mode'],
      \ }
let g:spacevim#plug#leaderGuide#lmap['h'] = {
      \ 'name' : '+help',
      \ }
let g:spacevim#plug#leaderGuide#lmap['j'] = {
      \ 'name' : '+jump',
      \ 'j' : ['call feedkeys("\<Plug>(easymotion-overwin-f)")', 'easymotion-goto-char'],
      \ 'J' : ['call feedkeys("\<Plug>(easymotion-overwin-f2)")', 'easymotion-goto-char-2'],
      \ 'l' : ['call feedkeys("\<Plug>(easymotion-overwin-line)")', 'jump-linewise'],
      \ 'w' : ['call feedkeys("\<Plug>(easymotion-overwin-w)")', 'jump-to-word-bidirectional'],
      \ 'f' : ['call feedkeys("\<Plug>(easymotion-prefix)w")', 'jump-forward-wordwise'],
      \ 'b' : ['call feedkeys("\<Plug>(easymotion-prefix)b")', 'jump-backword-wordwise'],
      \ }
let g:spacevim#plug#leaderGuide#lmap['p'] = {
      \ 'name' : '+projects',
      \ 'f' : ['call spacevim#plug#fzf#FindFileInProject()', 'find-file-in-project'],
      \ 's' : ['Rag', 'search-in-project'],
      \ }
let g:spacevim#plug#leaderGuide#lmap['q'] = [ 'q', 'quit' ]
let g:spacevim#plug#leaderGuide#lmap['Q'] = [ 'qa!', 'quit-without-saving' ]
let g:spacevim#plug#leaderGuide#lmap['s'] = {
      \ 'name' : '+search',
      \ 'c' : ['nohlsearch', 'search-clear-highlight']
      \ }
let g:spacevim#plug#leaderGuide#lmap['t'] = {
      \ 'name' : '+toggle',
      \ 'g' : ['GitGutterToggle', 'gitgutter'],
      \ 'i' : ['IndentGuidesToggle', 'indent-guide'],
      \ 'p' : ['setlocal paste!', 'paste-mode'],
      \ 's' : ['SyntasticToggleMode', 'syntastic'],
      \ 't' : ['TagbarToggle', 'tagbar'],
      \ 'c' : ['call spacevim#util#ToggleCursorColumn()', 'cursor-column'],
      \ 'C' : ['call spacevim#util#ToggleColorColumn()', 'color-column'],
      \ }
let g:spacevim#plug#leaderGuide#lmap['u'] = [ 'call feedkeys("\<C-u>")', 'scroll-up' ]

nnoremap <Plug>(window_w) <C-W>w
nnoremap <Plug>(window_r) <C-W>r
nnoremap <Plug>(window_d) <C-W>c
nnoremap <Plug>(window_q) <C-W>q
nnoremap <Plug>(window_j) <C-W>j
nnoremap <Plug>(window_k) <C-W>k
nnoremap <Plug>(window_h) <C-W>h
nnoremap <Plug>(window_l) <C-W>l
nnoremap <Plug>(window_H) <C-W>5<
nnoremap <Plug>(window_L) <C-W>5>
nnoremap <Plug>(window_J) :resize +5<CR>
nnoremap <Plug>(window_K) :resize -5<CR>
nnoremap <Plug>(window_b) <C-W>=
nnoremap <Plug>(window_s1) <C-W>s
nnoremap <Plug>(window_s2) <C-W>s
nnoremap <Plug>(window_v1) <C-W>v
nnoremap <Plug>(window_v2) <C-W>v
nnoremap <Plug>(window_2) <C-W>v

let g:spacevim#plug#leaderGuide#lmap['w'] = {
      \ 'name' : '+windows',
      \ 'w' : ['call feedkeys("\<Plug>(window_w)")', 'other-window'],
      \ 'd' : ['call feedkeys("\<Plug>(window_d)")', 'delete-window'],
      \ '-' : ['call feedkeys("\<Plug>(window_s1)")', 'split-window-below'],
      \ '|' : ['call feedkeys("\<Plug>(window_v1)")', 'split-window-right'],
      \ '2' : ['call feedkeys("\<Plug>(window_v1)")', 'layout-double-columns'],
      \ 'h' : ['call feedkeys("\<Plug>(window_h)")', 'window-left'],
      \ 'j' : ['call feedkeys("\<Plug>(window_j)")', 'window-below'],
      \ 'l' : ['call feedkeys("\<Plug>(window_l)")', 'window-right'],
      \ 'k' : ['call feedkeys("\<Plug>(window_k)")', 'window-up'],
      \ 'H' : ['call feedkeys("\<Plug>(window_H)")', 'expand-window-left'],
      \ 'J' : ['call feedkeys("\<Plug>(window_J)")', 'expand-window-below'],
      \ 'L' : ['call feedkeys("\<Plug>(window_L)")', 'expand-window-right'],
      \ 'K' : ['call feedkeys("\<Plug>(window_K)")', 'expand-window-up'],
      \ '=' : ['call feedkeys("\<Plug>(window_b)")', 'balance-window'],
      \ 's' : ['call feedkeys("\<Plug>(window_s1)")', 'split-window-below'],
      \ 'v' : ['call feedkeys("\<Plug>(window_v1)")', 'split-window-below'],
      \ '?' : ['Windows', 'fzf-window'],
      \ }
let g:spacevim#plug#leaderGuide#lmap['x'] = {
      \ 'name' : '+text',
      \ 'a' : ['call feedkeys("\<Plug>(EasyAlign)")', 'easy-align'],
      \ 'd' : ['StripWhitespace', 'delete-trailing-whitespace'],
      \ }
