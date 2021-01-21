" Reload .vimrc
nnoremap <Leader>fR :source $MYVIMRC<CR>

" Replace the word under cursor in current file
nnoremap <leader>rc :%s/\<<C-r><C-w>\>/

" if maparg('<C-I>', 'n') != ''
  " nunmap <C-I>
" endif

" Use Ctrl-Tab and Alt-Tab to switch tab
map    <C-Tab>  :tabnext<CR>
imap   <C-Tab>  <C-O>:tabnext<CR>
map    <M-Tab>  :tabprev<CR>
imap   <M-Tab>  <C-O>:tabprev<CR>

for s:i in range(1, 9)
  " <Leader>[1-9] move to window [1-9]
  execute 'nnoremap <Leader>'.s:i ' :'.s:i.'wincmd w<CR>'

  " <Leader><leader>[1-9] move to tab [1-9]
  execute 'nnoremap <Leader><Leader>'.s:i s:i.'gt'

  " <Leader>b[1-9] move to buffer [1-9]
  execute 'nnoremap <Leader>b'.s:i ':b'.s:i.'<CR>'
endfor
unlet s:i

" Picked from https://github.com/tpope/vim-unimpaired
" Move to core/ftplugin/qf.vim

" Buffers
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" Tabs
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" map y <Plug>(operator-flashy)
" nmap Y <Plug>(operator-flashy)$

" Startify
nnoremap <silent><Leader>bh :Startify<CR>

" vim-better-whitespace
nnoremap <Leader>xd :StripWhitespace<CR>

" vim-choosewin
nmap <Leader>ww <Plug>(choosewin)

" util
nnoremap <Leader>tc :call spacevim#vim#toggle#CursorColumn()<CR>
nnoremap <Leader>tC :call spacevim#vim#toggle#ColorColumn()<CR>

command! -bar -nargs=0 Rtp  :call spacevim#util#Runtimepath()
command!      -nargs=? Grep :call spacevim#vim#grep#Grep(<q-args>)
