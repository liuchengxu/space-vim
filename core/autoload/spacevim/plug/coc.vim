function! spacevim#plug#coc#Init(_timer) abort

  " This would cause the `doHover` action disappear automatically.
  " So disable it now.
  " autocmd CursorMoved * if &previewwindow != 1 | pclose | endif

  if !g:spacevim.nvim
    call coc#rpc#start_server()
  endif

  " Don't know why coc.nvim doesn't work until I do the autocmd CocNvimInit explicitly
  if exists('#User#CocNvimInit')
    doautocmd User CocNvimInit
  endif
endfunction

" wrap s:show_documentation from coc
function! spacevim#plug#coc#show_documentation()
  if &filetype == 'vim'
    execute 'help' expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
