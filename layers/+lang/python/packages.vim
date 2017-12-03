if g:spacevim_timer
  MP 'tmhedberg/SimpylFold',    { 'on': [] }
  MP 'python-mode/python-mode', { 'on': [] }
else
  MP 'tmhedberg/SimpylFold',    { 'for': 'python' }
  MP 'python-mode/python-mode', { 'for': 'python' }
endif
