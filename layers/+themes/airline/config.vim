scriptencoding=utf-8

" vim-airline {
  let g:airline_theme='violet'
  let g:Powerline_symbols='fancy'
  let g:airline#extensions#branch#enabled = 1
  let g:airline#extensions#tabline#enabled=1
  let g:airline#extensions#tabline#buffer_idx_mode = 1
  let g:airline#extensions#tabline#buffer_nr_show = 1
  let g:airline#extensions#tabline#buffer_nr_format = '%s:'
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#tabline#fnamecollapse = 1
  let g:airline#extensions#tabline#fnametruncate = 0
  let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
  let g:airline#extensions#default#section_truncate_width = {
              \ 'b': 79,
              \ 'x': 60,
              \ 'y': 88,
              \ 'z': 45,
              \ 'warning': 80,
              \ 'error': 80,
              \ }
  let g:airline#extensions#default#layout = [
              \ [ 'a', 'error', 'warning', 'b', 'c' ],
              \ [ 'x', 'y', 'z' ]
              \ ]
  " Distinct background color is enough to discriminate the warning and
  " error information.
  let g:airline#extensions#ale#error_symbol = '•'
  let g:airline#extensions#ale#warning_symbol = '•'
  autocmd User SpacevimAfterUserConfig call s:after_user_config()
  function! s:after_user_config() abort
     if !exists('g:airline_powerline_fonts')
       let g:airline_left_sep=''
       let g:airline_right_sep=''
       if !g:spacevim.os.windows
         let g:airline_symbols = g:spacevim#plug#airline#symbols
       endif
     endif
  endfunction
" }
