" From coc.nvim
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" tab, snippets
function! spacevim#vim#complete#Tab() abort
  let tab_or_snippet = "\<tab>"

  " Provide an option to disable the completion of coc.nvim,
  " since it is not that good for some filetypes. This also means you could
  " enable coc.nvim and ncm2 at the same time.
  if get(g:, 'did_coc_loaded', 0) && get(g:, 'spacevim_enable_coc_completion', 1)
    if pumvisible()
      call feedkeys("\<C-n>", 'n')
    elseif s:check_back_space()
      call feedkeys("\<Tab>", 'n')
    else
      call coc#refresh()
    endif
  else
    let key = pumvisible() ? "\<c-n>" : tab_or_snippet
    call feedkeys(key, 'n')
  endif

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
