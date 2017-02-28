<p align="left">
<a href="https://github.com/liuchengxu/space-vim"><img src="https://rawgit.com/liuchengxu/space-vim/master/assets/space-vim-badge.svg" alt="badge"></a>
<a href="https://github.com/liuchengxu/space-vim/blob/master/LICENSE"><img src="https://rawgit.com/liuchengxu/space-vim/master/assets/license.svg" alt="license"></a>
<a href="https://travis-ci.org/liuchengxu/space-vim"><img src="https://travis-ci.org/liuchengxu/space-vim.svg" alt="Build Status"></a>
</p>

--------------------

<p align="center"><img src="docs/img/space-vim.png" alt="space-vim"/></p>

<p align="center">
<b><a href="https://liuchengxu.github.io/space-vim/docs/org/tutorial_cn.html#orgheadline4">前言</a></b> |
<b><a href="https://liuchengxu.github.io/space-vim/docs/org/tutorial_cn.html#orgheadline5">运行截图</a></b> |
<b><a href="https://liuchengxu.github.io/space-vim/docs/org/tutorial_cn.html#orgheadline6">适用人群</a></b> |
<b><a href="https://liuchengxu.github.io/space-vim/docs/org/tutorial_cn.html#orgheadline14">开始使用</a></b> |
<b><a href="https://liuchengxu.github.io/space-vim/docs/org/tutorial_cn.html#orgheadline15">个性化</a></b> |
<b><a href="https://liuchengxu.github.io/space-vim/docs/org/tutorial_cn.html#orgheadline16">更新</a></b> |
<b><a href="https://liuchengxu.github.io/space-vim/docs/org/tutorial_cn.html#orgheadline19">默认安装</a></b> |
<b><a href="https://liuchengxu.github.io/space-vim/docs/org/tutorial_cn.html#orgheadline25">基础键位</a></b> |
<b><a href="https://liuchengxu.github.io/space-vim/docs/org/tutorial_cn.html#orgheadline28">使用建议</a></b>
</p>

### Table of Contents

<!-- vim-markdown-toc GFM -->
* [Introduction](#introduction)
* [Features](#features)
* [For whom?](#for-whom)
* [Install](#install)
    * [Linux and macOS](#linux-and-macos)
    * [Windows(experimental)](#windowsexperimental)
    * [Manual (Linux and macOS)](#manual-linux-and-macos)
* [Customize](#customize)
* [How to use](#how-to-use)
* [Update](#update)
* [FAQ](#faq)
* [Contributions](#contributions)
* [Acknowledgements](#acknowledgements)
* [Articles](#articles)

<!-- vim-markdown-toc -->

## Introduction

space-vim is a vim distribution for vim plugins and resources, compatible with Vim and NeoVim.

It is inspired by [spacemacs](https://github.com/syl20bnr/spacemacs) and mimics spacemacs in a high level, especially in the whole architecture, key bindings and GUI. if have ever tried spacemacs, you will find space-vim is very similar to it in user experience.

Elegance here means pleasing, graceful as well as simple. If you are unfamiliar with spacemacs, you can visit [spacemacs.org](http://spacemacs.org/doc/DOCUMENTATION.html) for more about the priciple behind that, which is also what space-vim seeks.

The distribution is completely customizable using `.spacevim`, which is equivalent to `.spacemacs` in spacemacs.

![screenshot](docs/img/screenshot.png)
(Terminal vim with space-vim-dark theme)

## Features

- **Beautiful interface:** I have also written a vim colorscheme [space-vim-dark](https://github.com/liuchengxu/space-vim-dark) based on spacemacs-dark theme. You could also try [spacemacs-theme.vim](https://github.com/colepeters/spacemacs-theme.vim), which looks nice in GUI vim.

    ![screenshot](https://github.com/liuchengxu/space-vim-dark/blob/screenshots/screenshot3.png?raw=true)
    (Terminal vim with `set termguicolors`)

- **Mnemonic key bindings:** commands have mnemonic prefixes like <kbd>SPC b</kbd> for all the buffer commands.

    Meanwhile, the whole key bindings have been well adapted for vim for the lack of great plugins similar to which-key in emacs. Most key bindings are limited to no more than two keystrokes without counting `<Leader>` or `<LocalLeader>` in, e.g. <kbd>SPC x d</kbd> to delete trailing whitespaces.

    For different language layers, `<LocalLeader>`, <kbd>,</kbd> as default in space-vim, can be seen as the major-mode prefix in spacemacs.

## For whom?

- the novice vim users
- the vimmers who pursuit a beautiful appearance
- the users **using both vim and spacemacs**

If you have been a vimmer for quite a while, just pick out the part you are interested in. space-vim is well-organized due to the layers concept, you can easily find what you want.

## Install

You have to satisfy some prerequisites at first:

- vim with `+python` or `+python3` feature.

    If `:echo has('python')` or `:echo has('python3')` returns `1`, then you are done. What's more, the most recent vim version is recommended.

- git.

:exclamation: ~~When layers enabled at the first time, you need to run `:PlugInstall` to install relevant plugins~~.

### Linux and macOS

- curl

    ```sh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/liuchengxu/space-vim/master/install.sh)"
    ```

- wget

    ```sh
    sh -c "$(wget -qO- https://raw.githubusercontent.com/liuchengxu/space-vim/master/install.sh)"
    ```

    :warning: For neovim, after the quick installer is done, you still need to create a symlink:

    ```sh
    ln -s ~/.space-vim/init.vim ~/.config/nvim/init.vim
    ```

### Windows(experimental)

1. [Download git](https://git-scm.com/download/win)

2. [Download Vim and Python](https://github.com/vim/vim-win32-installer/releases)

3. Download [vim-plug](https://github.com/junegunn/vim-plug#installation):

    **windows (PowerShell)**

    ```sh
    md ~\.vim\autoload
    $uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    (New-Object Net.WebClient).DownloadFile($uri, $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("~\.vim\autoload\plug.vim"))
    ```

4. Enter your home directory, Open *Git Bash* by right-clicking and choosing the option `Git Bash Here`. Run the following commands to download space-vim and make a symlink.

    ```sh
    git clone https://github.com/liuchengxu/space-vim.git ~/.space-vim
    ln -s ~/.space-vim/init.vim ~/.vimrc
    ```

5. Create `.spacevim` in home directory.

    ```vim
    function! Layers()
        Layer 'fzf'
        Layer 'unite'
        Layer 'better-defaults'
        " For chinese users
        Layer 'chinese'
    endfunction

    function! UserInit()
    endfunction

    function! UserConfig()
    endfunction
    ```

6. Open vim, run `:PlugInstall`.

### Manual (Linux and macOS)

1. Clone [space-vim](https://github.com/liuchengxu/space-vim)

    ```sh
    git clone https://github.com/liuchengxu/space-vim.git ~/.space-vim
    ```

2. Install [vim-plug](https://github.com/junegunn/vim-plug#installation), refer to vim-plug installation section for more information.

3. Create a symlink.

    ```sh
    # for vim
    ln -s ~/.space-vim/init.vim ~/.vimrc

    # for neovim
    ln -s ~/.space-vim/init.vim ~/.config/nvim/init.vim
    ```
4. (Optional) Install the [Source Code Pro](https://github.com/adobe-fonts/source-code-pro) or [Powerline](https://github.com/powerline/fonts) font.

    If you are running in terminal you'll need to change font settings of your terminal as well.

    ![iterm2_font_setting](docs/img/iterm2_powerline_setting.png)

5. Open vim, then space-vim will automatically install the missing plugins in enabled layers. If auto-installation fails unexpectly, please try running `:PlugInstall` manually.

## Customize

You can use `.spacevim` in your home directory to customize space-vim, where you can enable the existing layers, add your extra plugins and private configurations.

If `.spacevim` does not exist, none of the vim configurations will be loaded!

```vim
" You can enable the existing layers in space-vim and
" exclude the partial plugins in a certain layer.
" The command Layer and Exlcude are vaild in the function Layers().
function! Layers()

    " Default layers, recommended!
    Layer 'fzf'
    Layer 'unite'
    Layer 'better-defaults'

endfunction

" Put your private plugins here, e.g., change the colorscheme.
function! UserInit()

    " Space has been set as the default leader key,
    " Comma has been set at the default localleader key.
    " If you want to change it, uncomment and set it here.
    " let g:spacevim_leader = "your leader key"
    " let g:spacevim_localleader = 'your localleader key'

    " Install private plugins
    Plug 'morhetz/gruvbox'

endfunction

" Override the existing configurations and add extras here.
function! UserConfig()

    " color gruvbox

endfunction
```

If you want to use GUI color in terminal vim, add this to `UserConfig()`:

```vim
set termguicolors
" If you use vim inside tmux, see https://github.com/vim/vim/issues/993
" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
```

For more details about true colour, please see the gist [TrueColour.md](https://gist.github.com/XVilka/8346728).

If have a heavy customized configuration, you can organize them in **private** directory with `packages.vim` and `config.vim` too, which will be loaded on startup. The **private** directory can be considered as either a single layer, i.e., in which you can put packages.vim and config.vim, or a set of multiple layers.

## How to use

If you want to know more about the bootstrap of space-vim, please see [wiki](https://github.com/liuchengxu/space-vim/wiki/Bootstrap).

I recommend you to look through the existing key bindings via <kbd>SPC ?</kbd>. What's more, you definitely can not miss reading the README of [better-defaults layer](https://github.com/liuchengxu/space-vim/blob/master/layers/%2Bvim/better-defaults/README.md), which is of great importance for you to get started quickly.

For more information, please refer to the README under the certain layer enabled, or you can see config.vim and packages.vim directly.

If the README is not elaborate, sorry for that, space-vim now is in the early stages and a ton of stuff are waiting to be done.

## Update

The simplest way to update is to reinstall it completely by rerunning the installer above. It will non-destructively upgrade to the latest version.

Alternatively, you can manually perform the following steps. If anything has changed with the structure of the configuration, you will have to create the appropriate symlinks.

```sh
cd path/to/space-vim/
git pull origin master
```

## FAQ

>Q: Why develop this?

A: I was amazed by spacemacs' beautiful GUI and mnemonic key bindings when using it at the first time. Now I often use spacemacs when in GUI environment. But in the terminal, vim is definitely my first choice. Then I hope to maintain consistency in operation as much as possible in either scenario.
Hence I try to reconfigure the vim based on spacemacs' architecture, especially in key bindings and GUI. This is space-vim at present.

>Q: How do you think of spacemacs, space-vim as well as some other vim configurations/distributions derived from spacemacs?

A: Spacemacs' popularity indeed benefits a great number of people, making remarkable contributions to the community. I truly appreciate @syl20bnr and the whole contributors' outstanding works and have learnt many lessons from spacemacs.

For space-vim, it was merely a personal vim configuration for the purpose of convenience of users using vim and spacemacs at the same time. I am glad that some people like it and give many suggestions to improve it.

If you like space-vim and are willing to polish it, feel free to give any pieces of advice. However, it doesn't mean that I am positive on spending extra time joining some organization focusing on making a spacemacs-like vim distribution. I don't have enough time to maintain or contribute to another similar vim distribution.

It is encouraged to fork space-vim to build up your own personalized vim configuration. It's an open source project, you can turn it into any shape you like.

## Contributions

If you encounter any problem or have any suggestions, please [open an issue](https://github.com/liuchengxu/space-vim/issues/new) or [send a PR](https://github.com/liuchengxu/space-vim/pulls).

Space-vim is still in beta. If you are interested, contributions are highly welcome.

## Acknowledgements

I would like to thank the many people who have helped and contributed to this project. Furthermore, space-vim will never born without the following outstanding open source projects.

- [spacemacs](https://github.com/syl20bnr/spacemacs)
- [vim-plug](https://github.com/junegunn/vim-plug)
- [spf13-vim](https://github.com/spf13/spf13-vim)

## Articles

- [Use Vim as a Python IDE](http://www.liuchengxu.org/posts/use-vim-as-a-python-ide/)
- [A Vim Configuration for Spacemacs User](http://www.liuchengxu.org/posts/space-vim/)
- [用 Vim 写 Python 的最佳实践](https://www.v2ex.com/t/337102#reply61)
- [手工制作一个漂亮的 vim statusline ](https://segmentfault.com/a/1190000007939244)
