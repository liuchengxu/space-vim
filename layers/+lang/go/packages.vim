if g:spacevim.speed_up_via_timer
  MP 'fatih/vim-go', { 'on': [], 'do': ':GoInstallBinaries' }
else
  MP 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
endif
autocmd! User vim-go call spacevim#autocmd#go#Init()
