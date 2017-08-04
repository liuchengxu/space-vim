scriptencoding utf-8

augroup spacevimNewFile
  autocmd!
  " Add title automatically when new files and move cursor to the end of file
  autocmd BufNewFile *.py,*.rb,*.cpp,*.c,*.sh,*.java,*.pl call spacevim#auto#AddTitle()
  autocmd BufNewFile * normal GA
augroup END

" vim-move {
  " vim-move config
  " for terms that send Alt as Escape sequence
  " see http://vim.wikia.com/wiki/Mapping_fast_keycodes_in_terminal_Vim
  " for why the <F20> hack. Keeps Esc from waiting for other keys to exit visual
  set <F20>=j
  set <F21>=k
  vmap <F20> <Plug>MoveBlockDown
  vmap <F21> <Plug>MoveBlockUp
  nmap <F20> <Plug>MoveLineDown
  nmap <F21> <Plug>MoveLineUp
" }

" rainbow {
  let g:rainbow_active = 1
  let g:rainbow_conf = {
              \   'guifgs': ['#4F97D7', '#D75F87', '#D697E6', '#20AF81', '#2AA1AE', '#AF5F87'],
              \   'ctermfgs': ['68', '168', '176', '104', '73', '212'],
              \   'operators': '_,_',
              \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
              \   'separately': {
              \       '*': {},
              \       'tex': {
              \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
              \       },
              \       'lisp': {
              \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', '#FF69B4', '#DDA0DD', '#F08080', '#FF8C00', '#20B2AA'],
              \       },
              \       'vim': {
              \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
              \       },
              \       'html': {
              \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
              \       },
              \       'css': 0,
              \   }
              \}
" }

" rainbow_parentheses.vim {
  augroup rainbowLisp
    autocmd!
    autocmd FileType lisp,clojure,scheme RainbowParentheses
  augroup END
" }

" tagbar {
  let g:tagbar_autofocus = 1
  nnoremap <F6> :TagbarToggle<CR>
  inoremap <F6> <ESC>:TagbarToggle<CR>
  nnoremap <Leader>tt :TagbarToggle<CR>
  let g:tagbar_sort = 0
" }

" asyncrun.vim {
  nnoremap <F5> :call spacevim#util#CompileAndRun()<CR>
  augroup spacevimAsyncRun
    autocmd!
    let s:qf_height = float2nr(round(winheight('%') * 0.3))
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(s:qf_height, 1)
  augroup END
" }

" indentLine {
  let g:indentLine_char='¦'
  let g:indentLine_enabled=1
  let g:indentLine_color_term=239
  let g:indentLine_color_gui = '#4A9586'
  let g:indentLine_concealcursor='vc'      " default 'inc'
  let g:indentLine_fileTypeExclude = ['help', 'startify', 'vimfiler']
" }

" vim-indent-guides {
  let g:indent_guides_start_level = 2
  let g:indent_guides_guide_size = 1
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_auto_colors = 0
  nnoremap <Leader>ti :IndentGuidesToggle<CR>
" }

" vim-polyglot {
  " Reset errorformat to its default value for cooperating with asyncrun.vim
  autocmd BufEnter * set errorformat&
" }
