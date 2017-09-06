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
        \ 'ruby': [
          \ '#!/usr/bin/env ruby',
          \ '# encoding: utf-8'
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
    startinsert
  else
    call spacevim#util#err('spacevim#auto#AddTitle not supported in current filetype!')
  endif
endfunction
