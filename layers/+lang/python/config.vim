function! s:hi_over_length()
  highlight OverLength ctermbg=133 ctermfg=254 cterm=bold guibg=#592929
  match OverLength /\%81v.\+/
endfunction

augroup spacevimPython
  autocmd!
  " Force indentation styles for python
  autocmd FileType python setlocal
              \ foldmethod=indent
              \ tabstop=4
              \ shiftwidth=4
              \ softtabstop=4
              \ textwidth=79
              \ expandtab
              \ autoindent
              \ fileformat=unix

  autocmd FileType python nnoremap <LocalLeader>ho :call <SID>hi_over_length()<CR>

  if spacevim#funcs#LayerLoaded('programming')
    autocmd FileType python nnoremap <buffer> <F5> :update<Bar>execute 'AsyncRun! python '.shellescape(@%, 1)<CR>
    autocmd FileType python nnoremap <buffer> <LocalLeader>cc :update<Bar>execute 'AsyncRun! python '.shellescape(@%, 1)<CR>
    autocmd FileType python nnoremap <buffer> <LocalLeader>cs :update<Bar>execute 'AsyncStop!'<CR>
  else
    autocmd FileType python nnoremap <buffer> <F5> :update<Bar>execute '! python '.shellescape(@%, 1)<CR>
    autocmd FileType python nnoremap <buffer> <LocalLeader>cc :update<Bar>execute '! python '.shellescape(@%, 1)<CR>
  endif

  if executable('yapf')
    " Code formatter
    autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>
  else
    autocmd FileType python nnoremap <LocalLeader>= :call spacevim#util#err('yapf is unavailable, please install it first.')<CR>
  endif
augroup END

" python-mode {
  let g:pymode_lint_checkers = ['pyflakes']
  let g:pymode_trim_whitespaces = 0
  let g:pymode_options = 0
  let g:pymode_rope = 0

  let g:pymode_indent = 1
  let g:pymode_folding = 0
  let g:pymode_options_colorcolumn = 1
  let g:pymode_breakpoint_bind = '<leader>br'

  if spacevim#funcs#LayerLoaded('syntax-checking')
    let g:pymode_lint = 0
  endif
" }
