
if LayerLoaded('text-align')

    " tabular {
    if isdirectory(expand(g:my_plug_home.'tabular'))
        nmap <Leader>a& :Tabularize /&<CR>
        vmap <Leader>a& :Tabularize /&<CR>
        nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
        vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
        nmap <Leader>a=> :Tabularize /=><CR>
        vmap <Leader>a=> :Tabularize /=><CR>
        nmap <Leader>a: :Tabularize /:<CR>
        vmap <Leader>a: :Tabularize /:<CR>
        nmap <Leader>a:: :Tabularize /:\zs<CR>
        vmap <Leader>a:: :Tabularize /:\zs<CR>
        nmap <Leader>a, :Tabularize /,<CR>
        vmap <Leader>a, :Tabularize /,<CR>
        nmap <Leader>a,, :Tabularize /,\zs<CR>
        vmap <Leader>a,, :Tabularize /,\zs<CR>
        nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    endif
    " }

    " vim-easy-align {
    if isdirectory(expand(g:my_plug_home.'vim-easy-align'))
        " Start interactive EasyAlign in visual mode (e.g. vipga)
        xmap <Leader>xa <Plug>(EasyAlign)

        " Start interactive EasyAlign for a motion/text object (e.g. gaip)
        nmap <Leader>xa <Plug>(EasyAlign)
    endif
    " }

endif
