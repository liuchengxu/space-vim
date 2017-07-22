" Reload .vimrc
nnoremap <Leader>fR :source $MYVIMRC<CR>

" Use Tab to switch buffer
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>

" Use Ctrl-Tab and Alt-Tab to switch tab
map    <C-Tab>  :tabnext<CR>
imap   <C-Tab>  <C-O>:tabnext<CR>
map    <M-Tab>  :tabprev<CR>
imap   <M-Tab>  <C-O>:tabprev<CR>

" <Leader>[1-9] move to window [1-9]
for s:i in range(1, 9)
  execute 'nnoremap <Leader>' . s:i . ' :' . s:i . 'wincmd w<CR>'
endfor

" <Leader><leader>[1-9] move to tab [1-9]
for s:i in range(1, 9)
  execute 'nnoremap <Leader><Leader>' . s:i . ' ' . s:i . 'gt'
endfor

" <Leader>b[1-9] move to buffer [1-9]
for s:i in range(1, 9)
  execute 'nnoremap <Leader>b' . s:i . ' :b' . s:i . '<CR>'
endfor

" map y <Plug>(operator-flashy)
" nmap Y <Plug>(operator-flashy)$

" Startify
nnoremap <silent><Leader>bh :Startify<CR>

" vim-better-whitespace
nnoremap <Leader>xd :StripWhitespace<CR>

" vim-choosewin
nmap <Leader>ww <Plug>(choosewin)

" util
nnoremap <Leader>tc :call spacevim#util#ToggleCursorColumn()<CR>
nnoremap <Leader>tC :call spacevim#util#ToggleColorColumn()<CR>

command! -bar -nargs=0 Rtp :call spacevim#util#Runtimepath()

augroup spacevimGUI
  autocmd!
  autocmd GUIEnter * nnoremap <Leader>wm :call spacevim#gui#ToggleFullScreen()<CR>
augroup END
