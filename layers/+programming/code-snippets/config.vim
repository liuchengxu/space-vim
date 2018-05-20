scriptencoding utf-8

" ultisnips {
  " Set ultisnips triggers
  let g:UltiSnipsSnippetDirectories=['UltiSnips']
  exe 'set rtp+=' . expand(g:spacevim.base . '/private/UltiSnips')
  let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'

  let g:UltiSnipsExpandTrigger = '<C-e>'
  let g:UltiSnipsJumpForwardTrigger = '<C-j>'
  let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

  " tab map
  function! TabJumpNext()
   let snippet=UltiSnips#JumpForwards()
   if pumvisible()==0
     if g:ulti_jump_forwards_res==1
       return snippet
     else
       return "\<tab>"
     endif
   endif
  endfunction
  inoremap <expr> <tab> pumvisible() ? "<C-n>" : "<C-R>=TabJumpNext()<CR>"

  smap <TAB>   <Esc>:call UltiSnips#JumpForwards()<CR>

  function! STabJumpBack()
   let snippet=UltiSnips#JumpBackwards()
   if pumvisible()==0
     if g:ulti_jump_backwards_res==1
       return snippet
     else
       return "\<s-tab>"
     endif
   endif
  endfunction
  inoremap <expr> <s-tab> pumvisible() ? "<C-p>" : "<C-R>=STabJumpBack()<CR>"

  smap <S-TAB> <Esc>:call UltiSnips#JumpBackwards()<CR>
" }
