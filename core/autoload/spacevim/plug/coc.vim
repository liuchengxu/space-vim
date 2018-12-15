function! spacevim#plug#coc#Init(_timer) abort
  " Don't know why coc.nvim doesn't work until I do the autocmd CocNvimInit explicitly
  autocmd CursorMoved * if &previewwindow != 1 | pclose | endif

  if !g:spacevim.nvim
    call coc#rpc#start_server()
  endif

  if exists('#User#CocNvimInit')
    doautocmd User CocNvimInit
  endif

  call coc#config('coc.preferences', {
        \ 'timeout': 1000,
        \ 'hoverTarget': 'echo',
        \ 'languageserver': {
          \   'ccls': {
          \     "command": "ccls",
          \     "trace.server": "verbose",
          \     "filetypes": ["c", "cpp", "objc", "objcpp"]
          \ },
          \   "golang": {
          \     "command": "go-langserver",
          \     "filetypes": ["go"],
          \     "initializationOptions": {
          \       "gocodeCompletionEnabled": v:true,
          \       "diagnosticsEnabled": v:true,
          \       "lintTool": "golint"
          \       }
          \     }
          \   }
          \})
endfunction

" wrap s:show_documentation from coc
function! spacevim#plug#coc#show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
