if g:spacevim.timer
  MP 'fatih/vim-go', { 'on': [], 'do': ':GoInstallBinaries' }
else
  MP 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
endif
