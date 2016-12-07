<p align="center"><img src="doc/img/space-vim.png" alt="space-vim"/></p>

***

<p align="center">
:cn: <b><a href="doc/README_cn.md">中文简介</a></b>
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
* [Update](#update)
* [Contributions](#contributions)

<!-- vim-markdown-toc -->

## Introduction

At the very beginning, I just want to have a fully customized vim configuration, which is also convenient to rebuild the vim environment from scratch on a new machine.
Afterwards, I start to use [spacemacs](https://github.com/syl20bnr/spacemacs) and was amazed by its beautiful GUI as well as mnemonic key bindings.

Now, I often use spacemacs when in GUI environment. But in terminal, vim is definitely my first choice. Then I hope to maintain consistency in the two scenes as much as possible.
Hence I try to reconfig the vim based on spacemacs's architecture, especially in key bindings and GUI. This is space-vim at present. 

![screenshot](doc/img/screenshot.png)

## Features

- **Beautiful GUI:** I have also written a vim colorscheme based on spacemacs-dark theme.
- **Mnemonic key bindings:** commands have mnemonic prefixes like <kbd>SPC b</kbd> for all the buffer commands.

## Install

You have to satisfy some prerequsites at first: vim with `+python` or `+python3`, git.

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

## Customize

`.spacevim` in your home directory is similar to `.spacemacs` in spacemacs, where you can enable layers and put your own private configuration. If you have a heavy customized configuration, 

## Update

The simpliest way to update is to reinstall it completely by rerunning the installer above. It will non destructively upgrade to the latest version.

Alternatively you can manually perform the following steps. If anything has changed with the structure of the configuration, you will have to create the appropriate symlinks.

```sh
cd path/to/space-vim/
git pull
vim +PlugInstall! +PlugUpdate +PlugClean +q
```

## Contributions

Space-vim is still in beta. If you are interested too, contributions are highly welcome.

## Acknowledgements

- [spacemacs](https://github.com/syl20bnr/spacemacs)
- [vim-plug](https://github.com/junegunn/vim-plug)
- [spf13-vim](https://github.com/spf13/spf13-vim)
- ......
