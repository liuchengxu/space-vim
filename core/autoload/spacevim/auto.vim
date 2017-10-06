function!  spacevim#auto#AddTitle()
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
    execute "normal! G"
    call append(line("."), "")
    call append(line("."), "")
    execute "normal! G"
    startinsert
  else
    call spacevim#util#err('spacevim#auto#AddTitle not supported in current filetype!')
  endif
endfunction

function! spacevim#auto#AsyncRunStart()
    let s:qf_height = float2nr(round(winheight('%') * 0.3))
    call asyncrun#quickfix_toggle(s:qf_height, 1)
endfunction
