MP 'danro/rename.vim',               { 'on_cmd' : 'Rename' }

if exists('g:coc_global_extensions') && index(g:coc_global_extensions, 'coc-explorer') > -1
  " coc.nvim will handle this automatically.
else
  " Refer to https://github.com/junegunn/dotfiles  vimrc
  MP 'scrooloose/nerdtree', { 'on_cmd': ['NERDTreeToggle', 'NERDTreeFind'],
    \ 'hook_source': function('spacevim#autocmd#nerdtree#Init'),
    \ 'hook_post_source': 'call dein#source(\"nerdtree-git-plugin\")' }
    "\ .'| call dein#source(\"vim-nerdtree-syntax-highlight\")' }
  if get(g:, 'spacevim_nerd_fonts', 0)
    MP 'ryanoasis/vim-devicons'
  endif

  MP 'liuchengxu/nerdtree-dash'
  MP 'Xuyuanp/nerdtree-git-plugin', { 'lazy': 1 }

  " Disable vim-nerdtree-syntax-highlight for the performance consideration, see #237
  " MP 'tiagofumo/vim-nerdtree-syntax-highlight', { 'lazy': 1 }
endif
