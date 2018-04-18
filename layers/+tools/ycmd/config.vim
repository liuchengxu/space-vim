scriptencoding utf-8

" YouCompleteMe {
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
  let g:ycm_global_ycm_extra_conf = fnamemodify(expand('<sfile>'), ':h') . '/global_conf.py'
  set completeopt=menu,menuone
  let g:ycm_add_preview_to_completeopt = 0
  let g:ycm_semantic_triggers = g:spacevim#plug#youcompleteme#triggers
  let g:ycm_filetype_blacklist = g:spacevim#plug#youcompleteme#blacklist
  let g:ycm_show_diagnostics_ui = g:spacevim#plug#youcompleteme#disgnostics
  " let g:ycm_key_invoke_completion='<M-;>'

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

  " Fix tab conflict with YCM
  let g:ulti_expand_res = 0
  function! ExpandSnippetOrCarriageReturn()
      let snippet = UltiSnips#ExpandSnippet()
      if g:ulti_expand_res > 0
        return snippet
      else
        return "\<CR>"
      endif
  endfunction

  inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"
" }
