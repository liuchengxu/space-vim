" Reload .vimrc
nnoremap <Leader>fR :source $MYVIMRC<CR>
" Use Tab to switch buffer
nnoremap <Tab> :bn<CR>

" Startify
nnoremap <silent><Leader>bh :Startify<CR>

" vim-trailing-whitespace
nnoremap <Leader>xd :FixWhitespace<CR>

" incsearch.vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" easy-motion
" Default key bindings:
" <Leader><Leader>w : word
" <Leader><Leader>b : back
" <Leader><Leader>s : search
" <leader><Leader>f : forward
" <Leader><Leader>j
" <Leader><Leader>k
" Jump to line
map <Leader>jl <Plug>(easymotion-bd-jk)
nmap <Leader>jl <Plug>(easymotion-overwin-line)
" Jump to word
map  <Leader>jw <Plug>(easymotion-bd-w)
nmap <Leader>jw <Plug>(easymotion-overwin-w)

" nerdtree
map <F4> :NERDTreeToggle<CR>
imap <F4> <ESC>:NERDTreeToggle<CR>
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
