function! spacevim#autocmd#which_key#Init() abort
  call which_key#register('<Space>', 'g:spacevim#map#leader#desc')
  call which_key#register(',', 'g:spacevim#map#localleader#desc')
endfunction
