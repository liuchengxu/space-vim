if LayerLoaded('markdown')

    " vim-markdown {
    if isdirectory(expand(g:my_plug_home.'vim-markdown'))
        let g:vim_markdown_math=1
        let g:vim_markdown_frontmatter=1
    endif
    " }

    " vim-markdown-toc {
    if isdirectory(expand(g:my_plug_home.'vim-markdown-toc'))
        let g:vmt_auto_update_on_save = 1
        let g:vmt_dont_insert_fence = 0
    endif
    " }

endif
