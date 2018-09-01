function! spacevim#vim#autocmd#AddTitle() abort
  let l:template = {
        \ 'c': [
          \ '#include <stdio.h>'
          \ ],
        \ 'sh': [
          \ '#!/usr/bin/env bash'
          \ ],
        \ 'cpp': [
          \ '#include <iostream>',
          \ 'using namespace std;'
          \ ],
        \ 'perl': [
          \ '#!/usr/bin/perl',
          \ 'use strict;',
          \ 'use warnings;',
          \ 'use utf8;'
          \ ],
        \ 'python': [
          \ '#!/usr/bin/env python',
          \ '# -*- coding: utf-8 -*-'
          \ ],
        \}
  let l:ft = &filetype
  if has_key(l:template, l:ft)
    call setline(1, l:template[l:ft])
    normal! G
    call append(line("."), "")
    call append(line("."), "")
    normal! G
    startinsert
  else
    call spacevim#util#err('spacevim#auto#AddTitle not supported in current filetype!')
  endif
endfunction

" Deprecated, use g:asyncrun_open
function! spacevim#vim#autocmd#AsyncRunStart()
    let l:qf_height = float2nr(round(winheight('%') * 0.3))
    if !exists('*asyncrun#quickfix_toggle')
      call plug#load('asyncrun.vim')
    endif
    call asyncrun#quickfix_toggle(l:qf_height, 1)
endfunction
