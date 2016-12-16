scriptencoding utf-8

if LayerLoaded('syntax-checking')

    " ale
    if IsDir('ale')
        let g:ale_linters = {
                    \   'sh' : ['shellcheck'],
                    \   'vim' : ['vint'],
                    \   'html' : ['tidy'],
                    \   'python' : ['flake8'],
                    \   'markdown' : ['mdl'],
                    \   'javascript' : ['eslint'],
                    \}
        if index(g:layers_loaded, 'emoji') > -1
            let g:ale_sign_error = emoji#for('boom')
            let g:ale_sign_warning = emoji#for('small_orange_diamond')
        else
            let g:ale_sign_error = '✹'
            let g:ale_sign_warning = '✴'
        endif
        let g:ale_echo_msg_error_str = '✹ Error'
        let g:ale_echo_msg_warning_str = '⚠ Warning'
        let g:ale_echo_msg_format = '[#%linter%#] %s [%severity%]'
        let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
    endif

    " syntastic
    if IsDir('syntastic')
        let g:syntastic_python_checkers=['pyflakes']
        let g:syntastic_javascript_checkers=['jsl', 'jshint']
        let g:syntastic_html_checkers=['tidy', 'jshint']
        let g:syntastic_error_symbol='✹'
        let g:syntastic_warning_symbol='✴'
        let g:syntastic_aggregate_errors=1

        nnoremap <Leader>ts :SyntasticToggleMode<CR>
    endif

endif
