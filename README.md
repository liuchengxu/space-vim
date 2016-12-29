<p align="center"><img src="docs/img/space-vim.png" alt="space-vim"/></p>

***

<p align="center">
:cn: <b><a href="docs/README_cn.md">缘由</a></b> |
<b><a href="https://liuchengxu.github.io/space-vim/org/tutorial_cn.html#orgheadline5">运行截图</a></b> |
<b><a href="https://liuchengxu.github.io/space-vim/org/tutorial_cn.html#orgheadline6">适用人群</a></b> |
<b><a href="https://liuchengxu.github.io/space-vim/org/tutorial_cn.html#orgheadline14">开始使用</a></b> |
<b><a href="https://liuchengxu.github.io/space-vim/org/tutorial_cn.html#orgheadline15">个性化</a></b> |
<b><a href="https://liuchengxu.github.io/space-vim/org/tutorial_cn.html#orgheadline16">更新</a></b> |
<b><a href="https://liuchengxu.github.io/space-vim/org/tutorial_cn.html#orgheadline19">默认安装</a></b> |
<b><a href="https://liuchengxu.github.io/space-vim/org/tutorial_cn.html#orgheadline25">基础键位</a></b> |
<b><a href="https://liuchengxu.github.io/space-vim/org/tutorial_cn.html#orgheadline28">使用建议</a></b>
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
    * [Manual](#manual)
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

space-vim is a vim distribution for vim plugins and resources, compatible with Vim and NeoVim.

It is inspired by [spacemacs](https://github.com/syl20bnr/spacemacs), espcially in key bindings and GUI. if have ever tried spaceamcs, you will find spacevim is very similar to it in user experience.

The distribution is completely customisable using `.spacevim`, which is equivalent to `.spacemacs` in spacemacs.

![screenshot](docs/img/screenshot.png)

## Features

- **Beautiful interface:** I have also written a vim colorscheme [space-vim-dark](https://github.com/liuchengxu/space-vim-dark) based on spacemacs-dark theme.
    As space-vim-dark is intended for Terminal vim and have not optimized for GUI vim. I recommend you try [spacemacs-theme.vim](https://github.com/colepeters/spacemacs-theme.vim), which looks nice in GUI vim.

- **Mnemonic key bindings:** commands have mnemonic prefixes like <kbd>SPC b</kbd> for all the buffer commands. 
    Meanwhile, the whole key bindings have been well adapted for vim for the lack of something alike helm in emacs. Most key bindings are limited to no more than two keystrokes without counting `<Leader>` or `<LocalLeader>` in, e.g. <kbd>SPC x d</kbd> to delete trailing whitespaces.
    For different language layers, `<LocalLeader>` which is `,` as default in space-vim, can be seen as the major-mode prefix in spacemacs.

## Install

You have to satisfy some prerequisites at first: vim with `+python` or `+python3` feature, git.

:exclamation: When layers enabled at the first time, you need to run `:PlugInstall` to install relevant plugins.

### Linux and macOS

- curl

    ```sh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/liuchengxu/space-vim/master/install.sh)"
    ```

- wget

    ```sh
    sh -c "$(wget -qO- https://raw.githubusercontent.com/liuchengxu/space-vim/master/install.sh)"
    ```

    :warning: For neovim, after the quick installer is done, you still need to create some symlinks:

    ```sh
    ln -s ~/.space-vim/init.vim ~/.config/nvim/init.vim

    mkdir ~/.config/nvim/autoload
    ln -s ~/.vim/autoload/plug.vim ~/.config/nvim/autoload/plug.vim
    ```

### Windows

Not tested now.

### Manual

1. clone [space-vim](https://github.com/liuchengxu/space-vim)

    ```sh
    git clone https://github.com/liuchengxu/space-vim.git ~/.space-vim
    ```

2. install [vim-plug](https://github.com/junegunn/vim-plug#installation), refer to vim-plug installation section for more information.

3. create a symlink

    ```sh
    # for vim
    ln -s ~/.space-vim/init.vim ~/.vimrc

    # for neovim
    ln -s ~/.space-vim/init.vim ~/.config/nvim/init.vim

    mkdir ~/.config/nvim/autoload
    ln -s ~/.vim/autoload/plug.vim ~/.config/nvim/autoload/plug.vim
    ```

4. set up plugins

    ```sh
    vim +PlugInstall! +PlugClean +q
    ```

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

Use `Layer` command in `.spacevim` to enable a existing layer, e.g. `Layer 'python'`.

### `Exclude`

Use `Exclude` command in `.spacevim` to remove a plugin in the layers enabled, e.g. `Exclude 'Shougo/denite.nvim'`. If use `Exclude` command, you need to run `:PlugClean` to gurantee the relevant configurations not to be loaded.

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

A: I was amazed by spacemacs' beautiful GUI and mnemonic key bindings when use it at the first time. Now I often use spacemacs when in GUI environment. But in terminal, vim is definitely my first choice. Then I hope to maintain consistency in operation in the two scenes as much as possible.
Hence I try to reconfig the vim based on spacemacs's architecture, especially in key bindings and GUI. This is space-vim at present.

## Contributions

If you encounter any problem or have any suggestions, please [open an issue](https://github.com/liuchengxu/space-vim/issues/new) or [send a PR](https://github.com/liuchengxu/space-vim/pulls).

Space-vim is still in beta. If you are interested, contributions are highly welcome.

## Acknowledgements

- [spacemacs](https://github.com/syl20bnr/spacemacs)
- [vim-plug](https://github.com/junegunn/vim-plug)
- [spf13-vim](https://github.com/spf13/spf13-vim)
- ......
