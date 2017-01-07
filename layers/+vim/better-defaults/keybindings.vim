" Use Tab to switch buffer
nnoremap <Tab> :bn<CR>

" Use Ctrl-Tab and Alt-Tab to switch tab
map    <C-Tab>  :tabnext<CR>
imap   <C-Tab>  <C-O>:tabnext<CR>
map    <M-Tab>  :tabprev<CR>
imap   <M-Tab>  <C-O>:tabprev<CR>

" <Leader>w[1-9] move to window [1-9]
for i in range(1, 9)
    call SpacevimBind('map', i, 'window-' . i, i . 'wincmd w', 1)
endfor

" Startify
call SpacevimBind('map', 'bh', 'startify', 'Startify', 1)

" easy-motion{{{
" Default key bindings:
" <Leader><Leader>w : word
" <Leader><Leader>b : back
" <Leader><Leader>s : search
" <leader><Leader>f : forward
" <Leader><Leader>j
" <Leader><Leader>k

" Consistent with spacemacs
" <Leader>f{char} to move to {char}
call SpacevimBindPlug('map', 'jj', 'move-to-{char}', '(easymotion-s)')
call SpacevimBindPlug('nmap', 'jj', 'move-to-{char}', '(easymotion-overwin-f)')
call SpacevimBindPlug('nmap', 'jJ', 'move-to-{char}{char}', '(easymotion-overwin-f2)')
call SpacevimBindPlug('map', 'jl', 'move-to-line', '(easymotion-bd-jk)')
call SpacevimBindPlug('nmap', 'jl', 'move-to-line', '(easymotion-overwin-line)')
call SpacevimBindPlug('map', 'jw', 'move-to-word', '(easymotion-bd-w)')
call SpacevimBindPlug('nmap', 'jw', 'move-to-word', '(easymotion-overwin-w)')
call SpacevimBindPlug('map', 'j.', 'repeat', '(easymotion-repeat)')
"}}}


" vim-better-whitespace
call SpacevimBind('nmap', 'xd','strip-white-space', 'StripWhitespace', 1)

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
