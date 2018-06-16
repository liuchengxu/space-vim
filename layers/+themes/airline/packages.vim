if g:spacevim.timer
  MP 'vim-airline/vim-airline-themes' , { 'on': [] }
  MP 'vim-airline/vim-airline'        , { 'on': [] }
  " The waiting time for airline should be longer than the one for fugitive
  " and ale.
  call timer_start(250, 'spacevim#defer#airline')
else
  MP 'vim-airline/vim-airline-themes'
  MP 'vim-airline/vim-airline'
endif
