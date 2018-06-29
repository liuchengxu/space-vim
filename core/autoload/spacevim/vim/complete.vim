" tab, snippets
function! spacevim#vim#complete#Tab() abort
  let tab_or_snippet = "\<tab>"
  let key = pumvisible() ? "\<c-n>" : tab_or_snippet
  call feedkeys(key, 'n')
  return ''
endfunction

function! spacevim#vim#complete#STab() abort
  let tab_or_snippet = "\<s-tab>"
  let key = pumvisible() ? "\<C-p>" : tab_or_snippet
  call feedkeys(key, 'n')
  return ''
endfunction

function! spacevim#vim#complete#CR() abort
  let key = pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
  call feedkeys(key, 'n')
  return ''
endfunction
