" YouCompleteMe {
if isdirectory(expand("~/.vim/plugged/YouCompleteMe"))
    let g:ycm_global_ycm_extra_conf = g:spacevim_base_dir . '/layers/+tools/ycmd/global_conf.py'
    let g:ycm_error_symbol='✖'
    let g:ycm_warning_symbol='✴'
    " ycm_path_to_python_interpreter is important!
    let g:ycm_path_to_python_interpreter='python'
    let g:ycm_collect_identifiers_from_comments_and_strings=1
    let g:ycm_min_num_of_chars_for_completion=2
    let g:ycm_cache_omnifunc=0
    let g:ycm_seed_identifiers_with_syntax=1
    let g:ycm_complete_in_comments=1
    let g:ycm_complete_in_strings=1
    let g:ycm_collect_identifiers_from_comments_and_strings=0
    let g:ycm_filetype_blacklist={
                \ 'tagbar' : 1,
                \ 'nerdtree' : 1,
                \ 'markdown' : 1,
                \ 'unite' : 1,
                \ 'text' : 1,
                \ 'csv' : 1,
                \}
    let g:ycm_key_invoke_completion='<M-;>'
endif
" }


