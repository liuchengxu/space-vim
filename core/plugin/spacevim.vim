if exists('g:loaded_spacevim')
  finish
endif

let g:loaded_spacevim = 1

" Use gui colors in terminal if available
if has('termguicolors') && get(g:, 'spacevim_enable_true_color', 0)
  set termguicolors
  if g:spacevim.tmux
    " If use vim inside tmux, see https://github.com/vim/vim/issues/993
    " set Vim-specific sequences for RGB colors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
endif
