
MP 'rdnetto/YCM-Generator',  { 'on': ['YcmGenerateConfig', 'CCGenerateConfig'], 'branch': 'stable' }

MP 'ycm-core/YouCompleteMe', { 'do': function('spacevim#plug#youcompleteme#build'), 'on': [],
      \ 'on_event': ['CursorHold', 'CursorHoldI', 'InsertEnter'] }
autocmd! User YouCompleteMe call spacevim#autocmd#youcompleteme#Init()

if g:spacevim.speed_up_via_timer
  call timer_start(1000, 'spacevim#plug#youcompleteme#invoke')
endif
