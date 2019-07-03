" temporarily disabled
" MP 'Shougo/denite.nvim'
if g:spacevim.speed_up_via_timer
  MP 'Shougo/unite.vim', { 'on': [] }
  autocmd! User unite.vim call spacevim#autocmd#unite#Init()
  call timer_start(500, 'spacevim#defer#unite')
else
  MP 'Shougo/unite.vim'
endif
