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
* [Usage](#usage)
* [Update](#update)
* [Contributions](#contributions)
* [Acknowledgements](#acknowledgements)

<!-- vim-markdown-toc -->

## Introduction

At the very beginning, I just want to have a fully customized vim configuration, which is also handy to rebuild the vim environment from scratch on a new machine.
Afterwards, I start to use [spacemacs](https://github.com/syl20bnr/spacemacs) and was amazed by its beautiful GUI as well as mnemonic key bindings.

Now, I often use spacemacs when in GUI environment. But in terminal, vim is definitely my first choice. Then I hope to maintain consistency in operation in the two scenes as much as possible.
Hence I try to reconfig the vim based on spacemacs's architecture, especially in key bindings and GUI. This is space-vim at present. 

![screenshot](doc/img/screenshot.png)

## Features

- **Beautiful GUI:** I have also written a vim colorscheme based on spacemacs-dark theme.
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

## Customize

`.spacevim` in your home directory is similar to `.spacemacs` in spacemacs, where you can enable layers and put your own private configuration. 

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

If have a heavy customized configuration, you can organize them in private directory with `packages.vim` and `config.vim` too.

## Usage

For more information, you'd better refer to the README under the layer you want to enable or see config.vim and packages.vim directly.

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
