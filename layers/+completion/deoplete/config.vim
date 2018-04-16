scriptencoding utf-8

if g:spacevim_nvim || g:spacevim_vim8

    "    enter key map
    let g:ulti_expand_res = 0
    function ExpandSnippetOrCarriageReturn()
        let snippet = UltiSnips#ExpandSnippet()
        if g:ulti_expand_res > 0
            return snippet
        else 
          return deoplete#close_popup()
        endif
    endfunction

    inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"



    set completeopt-=preview  "close show_docstring
    let g:deoplete#enable_at_startup = 1
    " Set minimum syntax keyword length.
    let g:min_pattern_length=2
    
    " buffer improve
    let g:require_same_filetype='False'

    " delay
    let g:deoplete#auto_complete_delay=0
    " auto_refresh
    let g:auto_refresh_delay=0
    
    let refresh_always=true
    
    " customs
    call deoplete#custom#source('buffer', 'mark', 'ℬ')
    


    " Plugin key-mappings.
    inoremap <expr><C-g>     deoplete#undo_completion()
    inoremap <expr><C-l>     deoplete#refresh()

    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"

   
    " change snippets rank
    call deoplete#custom#source('ultisnips', 'rank', 1000)

    " register omni
    call deoplete#custom#source('omni', 'functions', {
    \ 'css' : 'csscomplete#CompleteCSS',
    \ 'html': 'htmlcomplete#CompleteTags',
    \ 'xml' : 'xmlcomplete#CompleteTags',
    \ })

		call deoplete#custom#source('omni', 'input_patterns', {
       " https://github.com/c9s/perlomni.vim
        \ 'perl': '\h\w*->\h\w*\|\h\w*::',     
		    \})

    function g:Multiple_cursors_before()

      call deoplete#custom#buffer_option('auto_complete', v:false)
    endfunction
    function g:Multiple_cursors_after()
      call deoplete#custom#buffer_option('auto_complete', v:true)
    endfunction
    
  " }
endif
