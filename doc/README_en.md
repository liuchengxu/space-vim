[Space-vim](https://github.com/liuchengxu/space-vim) is inspired by [spacemacs](https://github.com/syl20bnr/spacemacs), which is a community-driven emacs ditribution and has been the most famous emacs configuration.

As metioned in spacemacs, that the best editor is neither Emacs nor Vim, it's Emacs **and** Vim! So, both emacs and vim are worthy of trying.

In order to build a new vim distribution like spacemacs in emacs world, space-vim was born!

![screenshot](img/screenshot.png)

:warning: Space-vim now is in the early stages, a ton of stuff are waiting to be covered. Vimers, feel free to make a contribution!

You can customize space-vim with `.spacevim`, which you can put in your home directory, enable Layers and put your private configuration.

```vim
function! UserInit()

    " Space has been set as the default leader key,
    " if you want to change it, uncomment and set it here.
    " let g:spacevim_leader = "<\Space>"
    " let g:spacevim_localleader = ','

    " Put the layers you want to enable as well as extra private plugins
    Layer 'fzf'
    Layer 'ycmd'
    Layer 'syntax-checking'

    Layer 'emoji'
    Layer 'goyo'

    Layer 'html'
    Layer 'python'
    Layer 'markdown'
    Layer 'c-c++'

    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/vim-github-dashboard'

endfunction

function! UserConfig()

    " color gruvbox

endfunction
```

When you enable a certain layer, do not forget to reload .vimrc and run `:PlugInstall` to install related plugins.

