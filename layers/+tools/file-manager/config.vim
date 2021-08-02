scriptencoding utf-8

if exists('g:coc_global_extensions') && index(g:coc_global_extensions, 'coc-explorer') > -1

  function! s:CocExplorerFind() abort
    " Workaround for coc-explorer
    let coc_explorer = filter(range(1, bufnr('$')), 'getbufvar(v:val, "&filetype") ==# "coc-explorer"')
    " Close the coc-explorer panel if it's already opened.
    if !empty(coc_explorer)
      execute 'silent bwipeout!' coc_explorer[0]
    endif
    call timer_start(200, { -> execute('normal! zz') })
    let width = &columns / 5
    execute 'CocCommand explorer --reveal '.expand('%:p') '--width='.width
  endfunction

  function! s:CocExplorerToggle() abort
    let width = &columns / 5
    execute 'CocCommand explorer --toggle --width='.width
  endfunction

  nnoremap <silent> <Leader>ft :call <SID>CocExplorerToggle()<CR>
  nnoremap <silent> <Leader>fd :call <SID>CocExplorerFind()<CR>
else
  nnoremap <silent><F4> :NERDTreeToggle<CR>
  inoremap <silent><F4> <ESC>:NERDTreeToggle<CR>
  nnoremap <silent><Leader>ft :NERDTreeToggle<CR>
  nnoremap <silent><Leader>fd :NERDTreeFind<CR>
endif
