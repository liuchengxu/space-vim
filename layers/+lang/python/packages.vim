MP 'jeetsukumaran/vim-pythonsense'
if g:spacevim.speed_up_via_timer
  MP 'python-mode/python-mode', { 'rev': 'develop', 'lazy': 1 }
else
  MP 'python-mode/python-mode', { 'rev': 'develop', 'on_ft': 'python' }
endif
