scriptencoding utf-8

if LayerLoaded('git')

    " vim-fugitive {
    if IsDir('vim-fugitive')
        nnoremap <silent> <Leader>gs :Gstatus<CR>
        nnoremap <silent> <Leader>gd :Gdiff<CR>
        nnoremap <silent> <Leader>gc :Gcommit<CR>
        nnoremap <silent> <Leader>gb :Gblame<CR>
        nnoremap <silent> <Leader>gl :Glog<CR>
        nnoremap <silent> <Leader>gp :Git push<CR>
        nnoremap <silent> <Leader>gr :Gread<CR>
        nnoremap <silent> <Leader>gw :Gwrite<CR>
        nnoremap <silent> <Leader>ge :Gedit<CR>
        " Mnemonic _i_nteractive
        nnoremap <silent> <Leader>gi :Git add -p %<CR>
        nnoremap <silent> <Leader>gg :SignifyToggle<CR>
    endif
    "}

    " vim-gitgutter {
    if IsDir('vim-gitgutter')
        let g:gitgutter_sign_added = '++'
        let g:gitgutter_sign_modified = '**'
        let g:gitgutter_sign_removed = 'xx'
        let g:gitgutter_sign_removed_first_line = '^^'
        let g:gitgutter_sign_modified_removed = 'ww'
        let g:gitgutter_override_sign_column_highlight = 0
        nnoremap <silent> <Leader>tg :GitGuggterToggle<CR>
    endif
    " }

endif
