" easy-motion
" Default key bindings:
" <Leader><Leader>w : word
" <Leader><Leader>b : back
" <Leader><Leader>s : search
" <leader><Leader>f : forward
" <Leader><Leader>j
" <Leader><Leader>k

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

nmap s <Plug>(easymotion-overwin-f2)

" nerdtree
nnoremap <F4> :NERDTreeToggle<CR>
inoremap <F4> <ESC>:NERDTreeToggle<CR>

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
