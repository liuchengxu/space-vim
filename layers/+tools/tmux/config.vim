if g:spacevim.tmux
  if spacevim#load('unite')
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

" fix Ctrl arrow  tmux and vim --> https://stackoverflow.com/questions/15445481/mapping-arrow-keys-when-running-tmux
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
    execute "set <xHome>=\e[1;*H"
    execute "set <xEnd>=\e[1;*F"
endif


