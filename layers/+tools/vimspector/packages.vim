if g:spacevim.speed_up_via_timer
  MP 'puremourning/vimspector', { 'on': [] }
  call timer_start(900, 'spacevim#defer#vimspector')
else
  MP 'puremourning/vimspector'
endif
