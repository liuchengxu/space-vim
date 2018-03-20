
MP 'rdnetto/YCM-Generator',  { 'on': ['YcmGenerateConfig', 'CCGenerateConfig'], 'branch': 'stable' }

MP 'Valloric/YouCompleteMe', { 'do': function('spacevim#plug#youcompleteme#build'), 'on': [] }

if g:spacevim_timer
  call timer_start(1000, 'spacevim#plug#youcompleteme#invoke')
endif
augroup loadYcm
  autocmd!
  autocmd InsertEnter * call spacevim#plug#youcompleteme#load() | autocmd! loadYcm
augroup END
