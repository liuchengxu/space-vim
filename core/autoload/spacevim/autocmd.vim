function! spacevim#autocmd#GUIEnter() abort
  " http://stackoverflow.com/questions/5933568/disable-blinking-at-the-first-last-line-of-the-file
  set t_vb=

  " Refer to http://vim.wikia.com/wiki/Show_tab_number_in_your_tab_line
  set guioptions-=e

  " Restore screen
  let g:screen_size_restore_pos = get(g:, 'screen_size_restore_pos', 1)
  let g:screen_size_by_vim_instance = get(g:, 'screen_size_by_vim_instance', 1)
  autocmd VimEnter * if g:screen_size_restore_pos == 1 | call spacevim#vim#gui#ScreenRestore() | endif
  autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call spacevim#vim#gui#ScreenSave() | endif

  " Manipulate font size, from tpope
  command! Bigger  :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)+1', '')
  command! Smaller :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)-1', '')
  noremap + :Bigger<CR>
  noremap - :Smaller<CR>

  if g:spacevim.os.windows && empty(&guifont)
    let &guifont = 'Consolas:h13'
  endif

  nnoremap <Leader>wm :call spacevim#vim#gui#ToggleFullScreen()<CR>
endfunction
