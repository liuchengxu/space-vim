function! spacevim#plug#toggle#Git() abort
  if exists(':SignifyToggle')
    SignifyToggle
  elseif exists(':GitGutterToggle')
    GitGutterToggle
  else
    call spacevim#util#warn('Neither SignifyToggle nor GitGutterToggle found.')
  endif
endfunction

function! spacevim#plug#toggle#SidebarTags() abort
  if exists(':Vista')
    Vista
  elseif exists(':TagbarToggle')
    TagbarToggle
  else
    call spacevim#util#warn('Neither TagbarToggle nor Vista found.')
  endif
endfunction
