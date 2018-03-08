" https://github.com/scrooloose/nerdtree/issues/807
" remove the slashes after each directory node
setlocal conceallevel=3 | syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained

let s:colors = {
      \ 16: '#292b2e', 24: '#3C8380', 28: '#c269fe', 30: '#2aa1ae', 36: '#20af81', 40: '#00ff00',
      \ 59: '#FF73B9', 68: '#4f97d7', 75: '#FF62B0', 76: '#86dc2f', 81: '#f9bb00', 88: '#330033',
      \ 104: '#df90ff', 114: '#67b11d', 128: '#e76a49', 135: '#B7B7FF', 136: '#dc752f', 139: '#d698fe',
      \ 140: '#b888e2', 141: '#9a9aba', 151: '#74BAAC', 160: '#e0211d', 161: '#E469FE', 167: '#ce537a',
      \ 168: '#ce537a', 169: '#bc6ec5', 171: '#6094DB', 173: '#e18254', 176: '#E697E6', 177: '#D881ED',
      \ 178: '#d1951d', 179: '#d4b261', 196: '#e0211d', 204: '#ce537a', 207: '#FF68DD', 214: '#FF4848',
      \ 218: '#d19a66', 225: '#FFC8C8', 229: '#fff06a', 233: '#303030', 234: '#212026', 235: '#292b2e',
      \ 236: '#34323e', 238: '#544a65', 241: '#534b5d', 244: '#b4d1b6',
      \ }

" NERDTress File highlighting
function! s:hf(extension, fg, bg)
 exec 'highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. s:colors[a:bg] .' guifg='. s:colors[a:fg]
 exec 'syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call s:hf('md'  , 140 , 235)
call s:hf('org' , 140 , 235)
call s:hf('txt' , 140 , 235)

call s:hf('gitignore' , 81 , 235)
call s:hf('toml'      , 81 , 235)
call s:hf('yml'       , 81 , 235)
call s:hf('ini'       , 81 , 235)
call s:hf('info'      , 81 , 235)
call s:hf('json'      , 81 , 235)

call s:hf('png', 128, 235)
call s:hf('svg', 128, 235)
call s:hf('jpg', 128, 235)
