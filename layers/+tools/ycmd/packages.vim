
MP 'rdnetto/YCM-Generator',  { 'on': ['YcmGenerateConfig', 'CCGenerateConfig'], 'branch': 'stable' }

MP 'Valloric/YouCompleteMe', { 'do': function('spacevim#plug#youcompleteme#build'), 'on': [] }

if g:spacevim_timer
  call timer_start(1000, 'spacevim#plug#youcompleteme#invoke')
else
  augroup loadYcm
    autocmd!
    autocmd InsertEnter * call spacevim#plug#youcompleteme#invoke() | autocmd! loadYcm
  augroup END
endif
