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
      \ }
let g:spacevim#plug#leaderGuide#lmap['c'] = {
      \ 'name' : '+comment',
      \ }
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
      \ 'l' : ['call feedkeys("\<Plug>(easymotion-overwin-line)")', 'easymotion-goto-line'],
      \ 'w' : ['call feedkeys("\<Plug>(easymotion-overwin-w)")', 'easymotion-goto-word'],
      \ }
let g:spacevim#plug#leaderGuide#lmap['p'] = {
      \ 'name' : '+projects',
      \ 'h' : ['ProjectMru --tiebreak=end', 'helm-projectile'],
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
      \ }
let g:spacevim#plug#leaderGuide#lmap['u'] = [ 'call feedkeys("\<C-u>")', 'scroll-up' ]
let g:spacevim#plug#leaderGuide#lmap['w'] = {
      \ 'name' : '+windows',
      \ }
let g:spacevim#plug#leaderGuide#lmap['x'] = {
      \ 'name' : '+text',
      \ }
