function s:ctagsbin()
  if spacevim#load('go')
    if !exists('*go#path#CheckBinPath')
      call plug#load('vim-go')
    endif
    if exists('*go#path#CheckBinPath')
      return go#path#CheckBinPath(get(g:, 'go_gotags_bin', 'gotags'))
    else
      return 'gotags'
    endif
  endif
endfunction

let g:spacevim#lang#go#tagbar_type = {
      \ 'ctagstype' : 'go',
      \ 'kinds'     : [
      \ 'p:package',
      \ 'i:imports',
      \ 'c:constants',
      \ 'v:variables',
      \ 't:types',
      \ 'n:interfaces',
      \ 'w:fields',
      \ 'e:embedded',
      \ 'm:methods',
      \ 'r:constructor',
      \ 'f:functions'
      \ ],
      \ 'sro' : '.',
      \ 'kind2scope' : {
      \ 't' : 'ctype',
      \ 'n' : 'ntype'
      \ },
      \ 'scope2kind' : {
      \ 'ctype' : 't',
      \ 'ntype' : 'n'
      \ },
      \ 'ctagsbin'  : s:ctagsbin(),
      \ 'ctagsargs' : '-sort -silent'
      \ }

" run :GoBuild or :GoTestCompile based on the go file, refer to
" vim-go-tutorial
function! spacevim#lang#go#BuildGoFiles()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
