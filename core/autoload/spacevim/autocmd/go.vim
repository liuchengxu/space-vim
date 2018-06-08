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

function! spacevim#autocmd#go#Init()
  let g:go_highlight_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_build_constraints = 1
  let g:tagbar_type_go = {
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
endfunction
