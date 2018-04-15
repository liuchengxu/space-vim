scriptencoding utf-8

" ultisnips {
  " Set ultisnips triggers
  " let g:UltiSnipsSnippetDirectories=['UltiSnips']
  " exe 'set rtp+=' . expand(g:spacevim_dir . '/private/UltiSnips')
  " let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'

  " let g:UltiSnipsListSnippets = '<C-l>'
  " let g:UltiSnipsJumpForwardTrigger = '<C-j>'
  " let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

  " " Fix tab conflict with YCM
  " let g:UltiSnipsExpandTrigger = '<C-e>'
  " let g:ulti_expand_or_jump_res = 0
  " function! ExpandSnippetOrCarriageReturn()
    " let l:snippet = UltiSnips#ExpandSnippetOrJump()
    " if g:ulti_expand_or_jump_res > 0
      " return l:snippet
    " else
      " return "\<CR>"
    " endif
  " endfunction
  " inoremap <expr> <CR> pumvisible() ? "\<C-R>=ExpandSnippetOrCarriageReturn()\<CR>" : "\<CR>"
" }
  let g:UltiSnipsUsePythonVersion = 3
  let g:UltiSnipsSnippetDirectories=['UltiSnips']
  exe 'set rtp+=' . expand(g:spacevim_dir . '/private/UltiSnips')
  if g:spacevim_vim8
    let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
  endif
  if g:spacevim_nvim
    let g:UltiSnipsSnippetsDir =  '~/.config/nvim/UltiSnips'
  endif
  let g:UltiSnipsRemoveSelectModeMappings = 0

  let g:UltiSnipsJumpForwardTrigger = '<C-j>'
  let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
  let g:UltiSnipsExpandTrigger = "<C-e>"
  let g:ulti_expand_res = 0
  function ExpandSnippetOrCarriageReturn()
      let snippet = UltiSnips#ExpandSnippet()
      if g:ulti_expand_res > 0
          return snippet
      elseif !empty(glob("$HOME/.vim/plugged/completor.vim"))
        return "\<C-y>"
      elseif !empty(glob("$HOME/.local/share/nvim/plugged/deoplete.nvim")) ||  !empty(glob("$HOME/.vim/plugged/deoplete.nvim"))
        return deoplete#close_popup()
      endif
  endfunction

  inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"
  
  " make tab more dynamic
  function TabJumpNext()
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

  function STabJumpBack()
   let snippet=UltiSnips#JumpBackwards()
   if pumvisible()==0
     if g:ulti_jump_backwards_res==1
       return snippet
     else
       return "\<s-tab>"
     endif
   endif
  endfunction

  inoremap <expr> <s-tab> pumvisible() ? "<C-n>" : "<C-R>=TabJumpNext()<CR>"

  smap <TAB>   <Esc>:call UltiSnips#JumpForwards()<CR>
  smap <S-TAB> <Esc>:call UltiSnips#JumpBackwards()<CR>

