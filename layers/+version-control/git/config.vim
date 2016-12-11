if LayerLoaded('git')

    " vim-fugitive {
    if isdirectory(expand(g:my_plug_home.'vim-fugitive'))
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

endif
