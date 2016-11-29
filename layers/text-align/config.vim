
if index(g:layers_loaded, 'text-align')
    " tabular {
    if isdirectory(expand("~/.vim/plugged/tabular"))
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a\| :Tabularize /\|<CR>
        vmap <Leader>a\| :Tabularize /\|<CR>
        nmap <Leader>a: :Tabularize /:\zs<CR>
        vmap <Leader>a: :Tabularize /:\zs<CR>
    endif
    " }

    " vim-easy-align {
    if isdirectory(expand("~/.vim/plugged/vim-easy-align"))
        " Start interactive EasyAlign in visual mode (e.g. vipga)
        xmap <Leader>xa <Plug>(EasyAlign)

        " Start interactive EasyAlign for a motion/text object (e.g. gaip)
        nmap <Leader>xa <Plug>(EasyAlign)
    endif
    " }

endif
