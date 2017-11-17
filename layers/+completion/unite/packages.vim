" temporarily disabled
" MP 'Shougo/denite.nvim'
if g:spacevim_vim8 || g:spacevim_nvim
  MP 'Shougo/unite.vim', { 'on': [] }
  call timer_start(500, 'spacevim#defer#unite')
else
  MP 'Shougo/unite.vim'
endif
