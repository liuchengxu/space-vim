" https://github.com/scrooloose/nerdtree/issues/807
" remove the slashes after each directory node
setlocal conceallevel=3
syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained

" NERDTress File highlighting
function! s:hl(extension, group)
 exec 'highlight! link' a:extension a:group
 exec 'syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call s:hl('md'  , 'Constant')
call s:hl('org' , 'Constant')
call s:hl('txt' , 'Constant')

call s:hl('gitignore' , 'Define')
call s:hl('toml'      , 'Define')
call s:hl('yml'       , 'Define')
call s:hl('ini'       , 'Define')
call s:hl('info'      , 'Define')
call s:hl('json'      , 'Define')

call s:hl('png', 'Number')
call s:hl('svg', 'Number')
call s:hl('jpg', 'Number')
