" tabular {
  nmap <Leader>a&     :Tabularize /&<CR>
  vmap <Leader>a&     :Tabularize /&<CR>
  nmap <Leader>a=     :Tabularize /^[^=]*\zs=<CR>
  vmap <Leader>a=     :Tabularize /^[^=]*\zs=<CR>
  nmap <Leader>a=>    :Tabularize /=><CR>
  vmap <Leader>a=>    :Tabularize /=><CR>
  nmap <Leader>a:     :Tabularize /:<CR>
  vmap <Leader>a:     :Tabularize /:<CR>
  nmap <Leader>a::    :Tabularize /:\zs<CR>
  vmap <Leader>a::    :Tabularize /:\zs<CR>
  nmap <Leader>a,     :Tabularize /,<CR>
  vmap <Leader>a,     :Tabularize /,<CR>
  nmap <Leader>a,,    :Tabularize /,\zs<CR>
  vmap <Leader>a,,    :Tabularize /,\zs<CR>
  nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
  vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
" }

" vim-easy-align {
  " Start interactive EasyAlign in visual mode (e.g. vipxa)
  xmap <Leader>xa <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. xaip)
  nmap <Leader>xa <Plug>(EasyAlign)
" }
