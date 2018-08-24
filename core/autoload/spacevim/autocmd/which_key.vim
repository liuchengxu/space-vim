function! spacevim#autocmd#which_key#Init() abort
  call which_key#register_by_prefix('<Space>', 'g:spacevim#plug#which_key#leader')
endfunction
