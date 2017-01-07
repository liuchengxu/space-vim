if LayerLoaded('fzf')

    if !g:spacevim_gui_running
        " fzf.vim {
        if IsDir('fzf.vim')
            " Customize fzf colors to match your color scheme
            let g:fzf_colors = {
                        \ 'fg':      ['fg', 'Normal'],
                        \ 'bg':      ['bg', 'Normal'],
                        \ 'hl':      ['fg', 'Function'],
                        \ 'fg+':     ['fg', 'String', 'CursorColumn', 'Normal'],
                        \ 'bg+':     ['bg', 'Statusline', 'CursorColumn'],
                        \ 'hl+':     ['fg', 'Type'],
                        \ 'info':    ['fg', 'PreProc'],
                        \ 'prompt':  ['fg', 'Conditional'],
                        \ 'pointer': ['fg', 'Error'],
                        \ 'marker':  ['fg', 'String'],
                        \ 'spinner': ['fg', 'Label'],
                        \ 'header':  ['fg', 'Comment'],
                        \   }
        endif
        " }

    else
        nnoremap <Leader>? :nmap<CR>
    endif

endif

