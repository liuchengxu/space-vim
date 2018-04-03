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

"make shift+arrows and ctrl+arrows working in Vim in tmux
" https://superuser.com/questions/401926/how-to-get-shiftarrows-and-ctrlarrows-working-in-vim-in-tmux
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
    execute "set <xHome>=\e[1;*H"
    execute "set <xEnd>=\e[1;*F"
endif


