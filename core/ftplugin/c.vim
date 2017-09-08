setlocal cindent
        \ tabstop=2
        \ shiftwidth=2
        \ softtabstop=2

nnoremap <buffer> <LocalLeader>= :ClangFormat<CR>
vnoremap <buffer> <LocalLeader>= :<C-U>ClangFormat<CR>
nnoremap <buffer> <LocalLeader>m :<C-U>call spacevim#util#make()<CR>
