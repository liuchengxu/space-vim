function! spacevim#autocmd#which_key#Init() abort
  call which_key#register('<Space>', 'g:spacevim#map#leader#desc', 'n')
  call which_key#register(',', 'g:spacevim#map#localleader#desc', 'n')
  call which_key#register('<Space>', 'g:spacevim#map#leader#desc_visual', 'v')
  call which_key#register(',', 'g:spacevim#map#localleader#desc_visual', 'v')
endfunction
