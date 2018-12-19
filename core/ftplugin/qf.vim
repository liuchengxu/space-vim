" https://vi.stackexchange.com/questions/8534/make-cnext-and-cprevious-loop-back-to-the-begining
function! s:cycle(action, fallback) abort
  try
    execute a:action
  catch
    execute a:fallback
  finally
    normal! zz
  endtry
endfunction

nnoremap <silent> ]q :<c-u>call <SID>cycle('cnext', 'cfirst')<CR>
nnoremap <silent> [q :<c-u>call <SID>cycle('cprev', 'clast')<CR>

" Location
nnoremap <silent> ]l :<c-u>call <SID>cycle('lnext', 'lfirst')<CR>
nnoremap <silent> [l :<c-u>call <SID>cycle('lprev', 'llast')<CR>

nnoremap <silent> <buffer> q :cclose<bar>:lclose<CR>
nnoremap <buffer> <CR> <CR>

if exists('*SetMyStatusline')
  call SetMyStatusline('')
endif
