" easy-motion
" Default key bindings:
" <Leader><Leader>w : word
" <Leader><Leader>b : back
" <Leader><Leader>s : search
" <leader><Leader>f : forward
" <Leader><Leader>j
" <Leader><Leader>k

map <Leader><Leader> <Plug>(easymotion-prefix)

" Consistent with spacemacs
" <Leader>f{char} to move to {char}
map  <Leader>jj <Plug>(easymotion-bd-f)
nmap <Leader>jj <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap <Leader>jJ <Plug>(easymotion-overwin-f2)

" Jump to line
map <Leader>jl <Plug>(easymotion-bd-jk)
nmap <Leader>jl <Plug>(easymotion-overwin-line)

" Jump to word bidirectional
map  <Leader>jw <Plug>(easymotion-bd-w)
nmap <Leader>jw <Plug>(easymotion-overwin-w)

map <Leader>jf  <Plug>(easymotion-prefix)w
map <Leader>jb  <Plug>(easymotion-prefix)F

" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
