function! spacevim#autocmd#youcompleteme#Init() abort
  let g:ycm_error_symbol='✖'
  let g:ycm_warning_symbol='⚠ '
  let g:ycm_cache_omnifunc=0
  let g:ycm_complete_in_strings=1
  let g:ycm_complete_in_comments=1
  let g:ycm_seed_identifiers_with_syntax=1
  let g:ycm_min_num_of_chars_for_completion=2
  " ycm_path_to_python_interpreter is important!
  let g:ycm_path_to_python_interpreter='python'
  let g:ycm_autoclose_preview_window_after_completion = 1
  let g:ycm_collect_identifiers_from_comments_and_strings=0
  set completeopt=menu,menuone
  let g:ycm_add_preview_to_completeopt = 0
  let g:ycm_show_diagnostics_ui = spacevim#load('syntax-checking') ? 0 : 1
  " let g:ycm_key_invoke_completion='<M-;>'

  " https://github.com/Valloric/YouCompleteMe/issues/2875#issuecomment-358193287
  " automatically trigger semantic completion after typing 2 character in files
  let g:ycm_semantic_triggers = {
        \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
        \ 'cs,lua,javascript,rust': ['re!\w{2}'],
        \ }
  let g:ycm_filetype_blacklist = {
                \ 'tagbar' : 1,
                \ 'nerdtree' : 1,
                \ 'markdown' : 1,
                \ 'unite' : 1,
                \ 'text' : 1,
                \ 'csv' : 1,
                \}

  inoremap <expr> <Tab> spacevim#vim#complete#Tab()
  inoremap <expr> <S-Tab> spacevim#vim#complete#STab()
  inoremap <expr> <CR> spacevim#vim#complete#CR()

  augroup spacevimYcm
    autocmd!
    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

    " Key bindings
    autocmd FileType c,cpp,python,go,javascript,rust
                \   nnoremap <LocalLeader>gd :YcmCompleter GoTo<CR>
    autocmd FileType c,cpp,python,rust,javascript,typescript
                \   nnoremap <LocalLeader>gD :YcmCompleter GetDoc<CR>
    autocmd FileType c,cpp
                \   nnoremap <LocalLeader>gi :YcmCompleter GoToInclude<CR>
    autocmd FileType javascript,python,typescript
                \   nnoremap <LocalLeader>gr :YcmCompleter GoToReferences<CR>
    autocmd FileType c,cpp,javascript,typescript
                \   nnoremap <LocalLeader>gt :YcmCompleter GetType<CR>
    autocmd FileType c,cpp
                \   nnoremap <LocalLeader>gp :YcmCompleter GetParent<CR>
  augroup END

endfunction
