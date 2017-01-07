
if LayerLoaded('text-align')

    " tabular {
""    if IsDir('tabular')
""        nmap <Leader>a& :Tabularize /&<CR>
""        vmap <Leader>a& :Tabularize /&<CR>
""        nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
""        vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
""        nmap <Leader>a=> :Tabularize /=><CR>
""        vmap <Leader>a=> :Tabularize /=><CR>
""        nmap <Leader>a: :Tabularize /:<CR>
""        vmap <Leader>a: :Tabularize /:<CR>
""        nmap <Leader>a:: :Tabularize /:\zs<CR>
""        vmap <Leader>a:: :Tabularize /:\zs<CR>
""        nmap <Leader>a, :Tabularize /,<CR>
""        vmap <Leader>a, :Tabularize /,<CR>
""        nmap <Leader>a,, :Tabularize /,\zs<CR>
""        vmap <Leader>a,, :Tabularize /,\zs<CR>
""        nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
""        vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
""        vmap <Leader>a" :Tabularize /"<CR>
""        vmap <Leader>a# :Tabularize /#<CR>
""    endif
    " }

    " vim-easy-align {
""    if IsDir('vim-easy-align')
""        " Start interactive EasyAlign in visual mode (e.g. vipxa)
""        xmap <Leader>xa <Plug>(EasyAlign)
""
""        " Start interactive EasyAlign for a motion/text object (e.g. xaip)
""        nmap <Leader>xa <Plug>(EasyAlign)
""    endif
    " }

endif
