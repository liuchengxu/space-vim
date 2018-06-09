function! spacevim#autocmd#indent#Init()
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
" }
endfunction
