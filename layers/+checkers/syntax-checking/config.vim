scriptencoding utf-8

if g:spacevim.vim8 || g:spacevim.nvim
  " ale {
  let g:ale_linters = g:spacevim#plug#ale#linters
  let g:ale_set_highlights = 0
  let g:ale_echo_msg_format = '[#%linter%#] %s [%severity%]'
  let g:ale_statusline_format = ['E•%d', 'W•%d', 'OK']

  let g:ale_sign_error = g:spacevim#plug#ale#sign_error
  let g:ale_sign_warning = g:spacevim#plug#ale#sign_warning
  let g:ale_echo_msg_error_str = g:spacevim#plug#ale#echo_msg_error_str
  let g:ale_echo_msg_warning_str = g:spacevim#plug#ale#echo_msg_warning_str

  nmap <Leader>en <Plug>(ale_next)
  nmap <Leader>ep <Plug>(ale_previous)
  nnoremap <Leader>ts :ALEToggle<CR>

  " [DEPRECATED] Use ale#statusline#Count(buffer) instead
  " For a more fancy ale statusline
  function! ALEGetError()
    return spacevim#plug#ale#ALEGetError()
  endfunction
  function! ALEGetWarning()
    return spacevim#plug#ale#ALEGetWarning()
  endfunction
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
