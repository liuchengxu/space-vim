" unite.vim {
  " menu prefix key (for all Unite menus)
  nnoremap [menu] <Nop>
  nmap <LocalLeader> [menu]

  " unite.vim useful resources:
  " https://github.com/joedicastro/dotfiles/tree/master/vim
  " unite prefix: LocalLeader=','
  " menus menu
  nnoremap <silent>[menu]m :Unite -silent -winheight=40 menu<CR>

  nnoremap <silent>[menu]x :Unite -silent -winheight=20 menu:x<CR>
  nnoremap <silent>[menu]f :Unite -silent -winheight=20 menu:f<CR>
  nnoremap <silent>[menu]p :Unite -silent menu:p<CR>
  nnoremap <silent>[menu]t :Unite -silent menu:t<CR>
  nnoremap <silent>[menu]u :Unite -silent menu:u<CR>

  nnoremap <silent>[menu]v :call spacevim#map#manager#QuickOpen()<CR>

  if !g:spacevim.timer
    call spacevim#autocmd#unite#Init()
  endif
" }
