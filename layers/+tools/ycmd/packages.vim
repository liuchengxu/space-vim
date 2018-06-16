
MP 'rdnetto/YCM-Generator',  { 'on': ['YcmGenerateConfig', 'CCGenerateConfig'], 'branch': 'stable' }

MP 'Valloric/YouCompleteMe', { 'do': function('spacevim#plug#youcompleteme#build'), 'on': [] }
autocmd! User YouCompleteMe call spacevim#autocmd#youcompleteme#Init()

if g:spacevim.timer
  call timer_start(1000, 'spacevim#plug#youcompleteme#invoke')
endif
augroup loadYcm
  autocmd!
  autocmd CursorHold,CursorHoldI,InsertEnter * call spacevim#plug#youcompleteme#load() | autocmd! loadYcm
augroup END
