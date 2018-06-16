scriptencoding utf-8

if g:spacevim.vim8 || g:spacevim.nvim
  " ale {
  let g:ale_set_highlights = 0
  let g:ale_fix_on_save = 1
  let g:ale_echo_msg_format = '[#%linter%#] %s [%severity%]'
  let g:ale_statusline_format = ['E•%d', 'W•%d', 'OK']

  let g:ale_sign_error = '•'
  let g:ale_sign_warning = '•'
  let g:ale_echo_msg_error_str = g:spacevim.gui ? 'Error' : '✹ Error'
  let g:ale_echo_msg_warning_str = g:spacevim.gui ? 'Warning' : '⚠ Warning'

  nmap <Leader>en <Plug>(ale_next)
  nmap <Leader>ep <Plug>(ale_previous)
  nnoremap <Leader>ts :ALEToggle<CR>
  " }
else
  " syntastic {
  let g:syntastic_python_checkers=['pyflakes']
  let g:syntastic_javascript_checkers=['jsl', 'jshint']
  let g:syntastic_html_checkers=['tidy', 'jshint']
  let g:syntastic_error_symbol='✹'
  let g:syntastic_warning_symbol='✴'
  let g:syntastic_aggregate_errors=1

  nnoremap <Leader>ts :SyntasticToggleMode<CR>
  " }
endif
