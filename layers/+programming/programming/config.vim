scriptencoding utf-8

augroup spacevimNewFile
  autocmd!
  " Add title automatically when new files and move cursor to the end of file
  autocmd BufNewFile *.py,*.cpp,*.c,*.sh,*.java,*.pl call spacevim#vim#autocmd#AddTitle()
augroup END

" vim-move {
  " vim-move config
  " for terms that send Alt as Escape sequence
  " see http://vim.wikia.com/wiki/Mapping_fast_keycodes_in_terminal_Vim
  " for why the <F20> hack. Keeps Esc from waiting for other keys to exit visual
  set <F20>=j
  set <F21>=k
  set <F22>=h
  set <F23>=l
  vmap <F20> <Plug>MoveBlockDown
  vmap <F21> <Plug>MoveBlockUp
  vmap <F22> <Plug>MoveCharLeft
  vmap <F23> <Plug>MoveCharRight

  nmap <F20> <Plug>MoveLineDown
  nmap <F21> <Plug>MoveLineUp
  nmap <F22> <Plug>MoveCharLeft
  nmap <F23> <Plug>MoveCharRight
  if g:spacevim.nvim
    vmap <M-j> <Plug>MoveBlockDown
    vmap <M-k> <Plug>MoveBlockUp
    vmap <M-h> <Plug>MoveCharLeft
    vmap <M-l> <Plug>MoveCharRight

    nmap <M-j> <Plug>MoveLineDown
    nmap <M-k> <Plug>MoveLineUp
    nmap <M-h> <Plug>MoveCharLeft
    nmap <M-l> <Plug>MoveCharRight
  endif
" }

" rainbow {
  let g:rainbow_active = 1
  let g:rainbow_conf = {
            \   'guifgs': ['#4F97D7', '#D75F87', '#D697E6', '#40AF81', '#DA61AE', '#70AF67'],
            \   'ctermfgs': ['68', '168', '176', '104', '73', '212'],
            \   'operators': '_,_',
            \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
            \   'separately': {
            \       '*': 0,
            \   }
            \ }
  let g:rainbow_conf.separately.tex = {'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/']}
  let g:rainbow_conf.separately.lisp = {'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', '#FF69B4', '#DDA0DD', '#F08080', '#FF8C00', '#20B2AA']}
  let g:rainbow_conf.separately.vim = {'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody']}
  let g:rainbow_conf.separately.html = {'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold']}
  for s:ft in ['markdown', 'awk', 'bash', 'cpp', 'go', 'haskell', 'java', 'javascript','javascriptreact', 'lua', 'php', 'python', 'rust', 'scala', 'vim', 'xml', 'c', 'sh']
    let g:rainbow_conf.separately[s:ft] = {}
  endfor
" }

" rainbow_parentheses.vim {
  augroup rainbowLisp
    autocmd!
    autocmd FileType lisp,clojure,scheme RainbowParentheses
  augroup END
" }

" tagbar {
  let g:tagbar_sort = 0
  let g:tagbar_autofocus = 1
  nnoremap <F6> :TagbarToggle<CR>
  inoremap <F6> <ESC>:TagbarToggle<CR>
  nnoremap <Leader>tt :TagbarToggle<CR>
" }

" asyncrun.vim {
  let g:asyncrun_open = float2nr(round(winheight('%') * 0.3))
  nnoremap <F5> :call spacevim#plug#asyncrun#CompileAndRun()<CR>
" }

" vim-indent-guides {
  nnoremap <Leader>ti :IndentGuidesToggle<CR>
" }

" vim-polyglot {
  " Reset errorformat to its default value for cooperating with asyncrun.vim
  autocmd BufEnter * set errorformat&
" }

" vim-rooter {
  " To stop vim-rooter echoing the project directory
  let g:rooter_silent_chdir = 1
" }
