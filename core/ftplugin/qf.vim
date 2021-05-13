nnoremap <silent> ]q :<c-u>call spacevim#util#CycleQuickfix('cnext', 'cfirst')<CR>
nnoremap <silent> [q :<c-u>call spacevim#util#CycleQuickfix('cprev', 'clast')<CR>

" Location
nnoremap <silent> ]l :<c-u>call spacevim#util#CycleQuickfix('lnext', 'lfirst')<CR>
nnoremap <silent> [l :<c-u>call spacevim#util#CycleQuickfix('lprev', 'llast')<CR>

nnoremap <silent> <buffer> q :cclose<bar>:lclose<CR>
nnoremap <buffer> <CR> <CR>

setlocal nowrap

if exists('*SetMyStatusline')
  call SetMyStatusline('')
endif
