" ale
if isdirectory(expand("~/.vim/plugged/ale"))
    let g:ale_linters = {
                \   'javascript': ['eslint'],
                \   'python': ['flake8'],
                \   'html' : ['tidy'],
                \}
    if index(g:layers_loaded, 'emoji') > -1
        let g:ale_sign_error = emoji#for('x')
        let g:ale_sign_warning = emoji#for('small_red_triangle')
    else
        let g:ale_sign_error = '❌'
        let g:ale_sign_warning = '⭕'
    endif
    let g:ale_echo_msg_error_str = '✷ Error'
    let g:ale_echo_msg_warning_str = '⚠ Warning'
    let g:ale_echo_msg_format = '[#%linter%#] %s [%severity%]'
endif

" syntastic
if isdirectory(expand('~/.vim/plugged/syntastic'))
    let g:syntastic_python_checkers=['pyflakes']
    let g:syntastic_javascript_checkers=['jsl', 'jshint']
    let g:syntastic_html_checkers=['tidy', 'jshint']
    let g:syntastic_error_symbol='❌'
    let g:syntastic_warning_symbol='⭕'
    let g:syntastic_aggregate_errors=1

    nnoremap <Leader>ts :SyntasticToggleMode<CR>
endif
