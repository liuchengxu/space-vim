" YouCompleteMe {
  if g:spacevim.speed_up_via_timer
    call timer_start(1000, 'spacevim#plug#youcompleteme#invoke')
  endif

  let g:ycm_global_ycm_extra_conf = fnamemodify(expand('<sfile>'), ':h') . '/global_conf.py'
" }
