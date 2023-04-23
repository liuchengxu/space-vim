if g:spacevim.speed_up_via_timer
  MP 'fatih/vim-go', { 'hook_post_update': ':GoInstallBinaries',
    \ 'hook_source': function('spacevim#autocmd#go#Init'), 'lazy': 1 }
else
  MP 'fatih/vim-go', { 'hook_post_update': ':GoInstallBinaries',
    \ 'hook_source': function('spacevim#autocmd#go#Init'), 'on_ft': 'go' }
endif
