scriptencoding utf-8

if g:spacevim_nvim || g:spacevim_vim8
    inoremap <expr> <down> pumvisible() ? "\<C-n>" : "\<down>"
    inoremap <expr> <up> pumvisible() ? "\<C-p>" : "\<up>"
" deoplete.vim {
    set completeopt-=preview  "close show_docstring
    let g:deoplete#enable_at_startup = 1
    " Set minimum syntax keyword length.
    let g:min_pattern_length=2
    
    " buffer improve
    let g:require_same_filetype='False'

    " delay
    let g:deoplete#auto_complete_delay=20
    " auto_refresh
    let g:auto_refresh_delay=10
    
    let refresh_always=true
    
    " customs
    call deoplete#custom#source('buffer', 'mark', 'ℬ')


    " Plugin key-mappings.
    inoremap <expr><C-g>     deoplete#undo_completion()
    inoremap <expr><C-l>     deoplete#complete_common_string()

    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

   
    " change snippets rank
    call deoplete#custom#source('ultisnips', 'rank', 1000)

    " register omni
    call deoplete#custom#source('omni', 'input_patterns', {
    \ 'css' : 'csscomplete#CompleteCSS',
    \ 'html': 'htmlcomplete#CompleteTags',
    \ 'xml' : 'xmlcomplete#CompleteTags',
    \ 'perl': '\h\w*->\h\w*\|\h\w*::',      " https://github.com/c9s/perlomni.vim
    \ })
    
    " fix the conflict with multiple_cursors
    function g:Multiple_cursors_before()

      call deoplete#custom#buffer_option('auto_complete', v:false)
    endfunction
    function g:Multiple_cursors_after()
      call deoplete#custom#buffer_option('auto_complete', v:true)
    endfunction
" }
endif
