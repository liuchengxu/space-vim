function! spacevim#plug#toggle#Git()
  if exists(':SignifyToggle')
    SignifyToggle
  elseif exists(':GitGutterToggle')
    GitGutterToggle
  else
    call spacevim#util#warn('Neither SignifyToggle nor GitGutterToggle found.')
  endif
endfunction
