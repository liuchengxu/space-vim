<p align="center"><img src="doc/img/space-vim.png" alt="space-vim"/></p>

***

<p align="center">
:cn: <b><a href="README_cn.md">中文简介</a></b>
</p>
***
<p align="center">
<a href="https://github.com/liuchengxu/space-vim"><img src="https://rawgit.com/liuchengxu/space-vim/master/assets/space-vim-badge.svg" alt="badge"></a>
<a href="https://github.com/liuchengxu/space-vim/blob/master/LICENSE"><img src="https://rawgit.com/liuchengxu/space-vim/master/assets/license.svg" alt="license"></a>
</p>
***

### Table of Contents

<!-- vim-markdown-toc GFM -->
* [Introduction](#introduction)
* [Features](#features)
* [Install](#install)
    * [Linux and macOS](#linux-and-macos)
    * [Windows](#windows)
* [Customize](#customize)
* [Command](#command)
    * [`Layer`](#layer)
    * [`Exclude`](#exclude)
* [Update](#update)
* [FAQ](#faq)
* [Contributions](#contributions)
* [Acknowledgements](#acknowledgements)

<!-- vim-markdown-toc -->

## Introduction

space-vim is a vim distribution for vim plugins and resources, compatible with Vim and Neovim.

It is inspired by [spacemacs](https://github.com/syl20bnr/spacemacs), espcially in key bindings and GUI. if have ever tried spaceamcs, you will find spacevim is very similar to it in user experience.

The distribution is completely customisable using `.spacevim`, which is equivalent to `.spacemacs` in spacemacs.

![screenshot](doc/img/screenshot.png)

## Features

- **Beautiful GUI:** I have also written a vim colorscheme [space-vim-dark](https://github.com/liuchengxu/space-vim-dark) based on spacemacs-dark theme.
- **Mnemonic key bindings:** commands have mnemonic prefixes like <kbd>SPC b</kbd> for all the buffer commands.

## Install

You have to satisfy some prerequisites at first: vim with `+python` or `+python3` feature, git.

### Linux and macOS

- curl

    ```sh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/liuchengxu/space-vim/master/install.sh)"
    ```

- wget

    ```sh
    sh -c "$(wget -qO- https://raw.githubusercontent.com/liuchengxu/space-vim/master/install.sh)"
    ```

### Windows

Not tested now.

:warning: For neovim, after the installer is done, you still need to create a symlink:

```sh
ln -s ~/.space-vim/init.vim ~/.config/nvim/init.vim
```

:exclamation: When layers enabled at first time, you need to run `:PlugInstall` to install relevant plugins.

## Customize

You can use `.spacevim` in your home directory to customize space-vim, where you can enable existing layers, add your extra plugins and private configuration.

```vim
" Put layers you want to enable as well as extra private plugins
function! UserInit()
    " Space has been set as the default leader key,
    " if you want to change it, uncomment and set it here.
    " let g:spacevim_leader = "<\Space>"
    " let g:spacevim_localleader = ','

    " Put the layers you want to enable
    " Layer 'emoji'

    " Put private plugins
    " Plug 'junegunn/vim-github-dashboard'
endfunction

" Customize configuration
function! UserConfig()
    " color space-vim-dark
endfunction
```

If have a heavy customized configuration, you can organize them in private directory with `packages.vim` and `config.vim` too, which will be loaded on startup.

## Command

### `Layer`

Use `Layer` command in `.spacevim` to enable a existing layer, e.g., `Layer 'python'`.

### `Exclude`

Use `Exclude` command in `.spacevim` to remove a plugin in the layers enabled, e.g., `Exclude 'Shougo/denite.nvim'`. If use `Exclude` command, you need to run `:PlugClean` to gurantee the relevant configurations not to be loaded.

For more information, please refer to the README under the layer enabled, or you can see config.vim and packages.vim directly.

If the README is not elaborate, sorry for that, space-vim now is in the early stages and a ton of stuffs are waitting to be done.

## Update

The simpliest way to update is to reinstall it completely by rerunning the installer above. It will non destructively upgrade to the latest version.

Alternatively you can manually perform the following steps. If anything has changed with the structure of the configuration, you will have to create the appropriate symlinks.

```sh
cd path/to/space-vim/
git pull
vim +PlugInstall! +PlugUpdate +PlugClean +q
```

## FAQ

Q: Why develop this?

A: I often use spacemacs when in GUI environment. But in terminal, vim is definitely my first choice. Then I hope to maintain consistency in operation in the two scenes as much as possible.
Hence I try to reconfig the vim based on spacemacs's architecture, especially in key bindings and GUI. This is space-vim at present.

## Contributions

Space-vim is still in beta. If you are interested, contributions are highly welcome.

## Acknowledgements

- [spacemacs](https://github.com/syl20bnr/spacemacs)
- [vim-plug](https://github.com/junegunn/vim-plug)
- [spf13-vim](https://github.com/spf13/spf13-vim)
- ......
