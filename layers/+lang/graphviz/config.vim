" wmgraphviz.vim {
    augroup SPACEVIM_DOT
        autocmd FileType dot nnoremap <LocalLeader>c :update<CR>:GraphvizCompile<CR><CR>
        autocmd FileType dot nnoremap <LocalLeader>s :update<CR>:GraphvizShow<CR><CR>
    augroup END
" }
