if LayerLoaded('markdown')

    augroup SPACEVIM_MARKDOWN        
        " Markdown headings
        autocmd FileType markdown nnoremap <LocalLeader>1 m`yypVr=``
        autocmd FileType markdown nnoremap <LocalLeader>2 m`yypVr-``
        autocmd FileType markdown nnoremap <LocalLeader>3 m`^i### <esc>``4l
        autocmd FileType markdown nnoremap <LocalLeader>4 m`^i#### <esc>``5l
        autocmd FileType markdown nnoremap <LocalLeader>5 m`^i##### <esc>``6l
    augroup END

    " vim-markdown {
    if IsDir('vim-markdown')
        let g:vim_markdown_math=1
        let g:vim_markdown_frontmatter=1
    endif
    " }

    " vim-markdown-toc {
    if IsDir('vim-markdown-toc')
        let g:vmt_auto_update_on_save = 1
        let g:vmt_dont_insert_fence = 0
    endif
    " }

    " vim-xmark {
    if IsDir('vim-xmark')
        augroup SPACEVIM_MD
            autocmd FileType markdown nnoremap <LocalLeader>cp :Xmark<CR>
        augroup END
    endif
    " }

endif
