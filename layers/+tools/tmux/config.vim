if g:spacevim_tmux
  if spacevim#LayerLoaded('unite')
      "CtrlP tmux window
      nnoremap <Leader>mw :CtrlPTmux w<cr>
      "CtrlP tmux buffer
      nnoremap <Leader>mf :CtrlPTmux b<cr>
      "CtrlP tmux session
      nnoremap <Leader>mm :CtrlPTmux<cr>
      "CtrlP tmux command
      nnoremap <Leader>md :CtrlPTmux c<cr>
      "CtrlP tmux command interactively
      nnoremap <Leader>mi :CtrlPTmux ci<cr>
  endif
  "let g:tmuxify_map_prefix = '<leader>u'
endif
