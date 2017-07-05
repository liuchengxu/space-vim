augroup spacevimJava
  autocmd FileType java setlocal omnifunc=javacomplete#Complete
augroup END

" The commented key mappings are the defaults by vim-javacomplete2.
" nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
" imap <F4> <Plug>(JavaComplete-Imports-AddSmart)
autocmd FileType java nnoremap <LocalLeader>iA <Plug>(JavaComplete-Imports-AddSmart)
autocmd FileType java inoremap <LocalLeader>iA <Plug>(JavaComplete-Imports-AddSmart)

" nmap <F5> <Plug>(JavaComplete-Imports-Add)
" imap <F5> <Plug>(JavaComplete-Imports-Add)
autocmd FileType java nnoremap <LocalLeader>ia <Plug>(JavaComplete-Imports-Add)
autocmd FileType java inoremap <LocalLeader>ia <Plug>(JavaComplete-Imports-Add)

" nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
" imap <F6> <Plug>(JavaComplete-Imports-AddMissing)
autocmd FileType java nnoremap <LocalLeader>im <Plug>(JavaComplete-Imports-AddMissing)
autocmd FileType java inoremap <LocalLeader>im <Plug>(JavaComplete-Imports-AddMissing)

" nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
" imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
autocmd FileType java nnoremap <LocalLeader>ir <Plug>(JavaComplete-Imports-RemoveUnused)
autocmd FileType java inoremap <LocalLeader>ir <Plug>(JavaComplete-Imports-RemoveUnused)

" nmap <leader>jI <Plug>(JavaComplete-Imports-AddMissing)
" nmap <leader>jR <Plug>(JavaComplete-Imports-RemoveUnused)
" nmap <leader>ji <Plug>(JavaComplete-Imports-AddSmart)
" nmap <leader>jii <Plug>(JavaComplete-Imports-Add)

" imap <C-j>I <Plug>(JavaComplete-Imports-AddMissing)
" imap <C-j>R <Plug>(JavaComplete-Imports-RemoveUnused)
" imap <C-j>i <Plug>(JavaComplete-Imports-AddSmart)
" imap <C-j>ii <Plug>(JavaComplete-Imports-Add)

" nmap <leader>jM <Plug>(JavaComplete-Generate-AbstractMethods)

" imap <C-j>jM <Plug>(JavaComplete-Generate-AbstractMethods)

" nmap <leader>jA <Plug>(JavaComplete-Generate-Accessors)
" nmap <leader>js <Plug>(JavaComplete-Generate-AccessorSetter)
" nmap <leader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
" nmap <leader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)
" nmap <leader>jts <Plug>(JavaComplete-Generate-ToString)
" nmap <leader>jeq <Plug>(JavaComplete-Generate-EqualsAndHashCode)
" nmap <leader>jc <Plug>(JavaComplete-Generate-Constructor)
" nmap <leader>jcc <Plug>(JavaComplete-Generate-DefaultConstructor)

" imap <C-j>s <Plug>(JavaComplete-Generate-AccessorSetter)
" imap <C-j>g <Plug>(JavaComplete-Generate-AccessorGetter)
" imap <C-j>a <Plug>(JavaComplete-Generate-AccessorSetterGetter)

" vmap <leader>js <Plug>(JavaComplete-Generate-AccessorSetter)
" vmap <leader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
" vmap <leader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)
