scriptencoding utf-8

inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

if g:spacevim_vim8
  " Buffer
  autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
        \ 'name': 'buffer',
        \ 'whitelist': ['*'],
        \ 'blacklist': ['go', 'rust'],
        \ 'completor': function('asyncomplete#sources#buffer#completor'),
        \ }))
  " Go
  autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#gocode#get_source_options({
        \ 'name': 'gocode',
        \ 'whitelist': ['go'],
        \ 'completor': function('asyncomplete#sources#gocode#completor'),
        \ 'config': {
        \    'gocode_path': expand('~/go/bin/gocode')
        \  },
        \ }))
  " Rust
  autocmd User asyncomplete_setup call asyncomplete#register_source({
        \ 'name': 'racer',
        \ 'whitelist': ['rust'],
        \ 'completor': function('asyncomplete#sources#racer#completor')
        \ })
endif
