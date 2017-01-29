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

" Jump to word
map  <Leader>jw <Plug>(easymotion-bd-w)
nmap <Leader>jw <Plug>(easymotion-overwin-w)

" nerdtree
nnoremap <F4> :NERDTreeToggle<CR>
inoremap <F4> <ESC>:NERDTreeToggle<CR>
nnoremap <Leader>ft :NERDTreeToggle<CR>

let s:lines=&lines
let s:columns=&columns
function! s:enter_full_screen()
    set lines=999 columns=999
    set fullscreen
endfunction

function! s:leave_full_screen()
    let &lines=s:lines
    let &columns=s:columns
    set nofullscreen
endfunction

function! s:full_screen_toggle()
    if &fullscreen
        call s:leave_full_screen()
    else
        call s:enter_full_screen()
    endif
endfunction

augroup SPACEVIM_GUI
    autocmd!
    autocmd GUIEnter * nnoremap <Leader>wm :call <SID>full_screen_toggle()<CR>
augroup END
