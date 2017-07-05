scriptencoding utf-8

" ultisnips {
  " Set ultisnips triggers
  let g:UltiSnipsSnippetDirectories=['UltiSnips']
  exe 'set rtp+=' . expand(g:spacevim_dir . '/private/UltiSnips')
  let g:UltiSnipsSnippetsDir = [g:spacevim_dir.'/private/UltiSnips', g:spacevim_plug_home.'vim-snippets/UltiSnips/']

  let g:UltiSnipsListSnippets = '<C-l>'
  let g:UltiSnipsJumpForwardTrigger = '<C-j>'
  let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

  " Fix tab conflict with YCM
  let g:UltiSnipsExpandTrigger = '<C-e>'
  let g:ulti_expand_or_jump_res = 0
  function! ExpandSnippetOrCarriageReturn()
    let l:snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
      return l:snippet
    else
      return "\<CR>"
    endif
  endfunction
  inoremap <expr> <CR> pumvisible() ? "\<C-R>=ExpandSnippetOrCarriageReturn()\<CR>" : "\<CR>"
" }
