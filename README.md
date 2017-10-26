<p align="left">
<a href="https://github.com/liuchengxu/space-vim"><img src="https://rawgit.com/liuchengxu/space-vim/master/assets/space-vim-badge.svg" alt="badge"></a>
<a href="https://github.com/liuchengxu/space-vim/blob/master/LICENSE"><img src="https://rawgit.com/liuchengxu/space-vim/master/assets/license.svg" alt="license"></a>
<a href="https://travis-ci.org/liuchengxu/space-vim"><img src="https://travis-ci.org/liuchengxu/space-vim.svg" alt="Build Status"></a>
</p>

--------------------

<p align="center"><img src="https://github.com/liuchengxu/space-vim/blob/gh-pages/docs/img/space-vim.png?raw=true" alt="space-vim"/></p>

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
  * [Prerequisites](#prerequisites)
  * [Linux and macOS](#linux-and-macos)
    * [one-line installer](#one-line-installer)
    * [`Makefile`](#makefile)
  * [Windows](#windows)
  * [Manual (Linux and macOS)](#manual-linux-and-macos)
* [Customize](#customize)
  * [Presetting](#presetting)
  * [`Layers()`](#layers)
  * [`UserInit()`](#userinit)
  * [`UserConfig()`](#userconfig)
* [How to use](#how-to-use)
  * [Bootstrap](#bootstrap)
  * [Commands](#commands)
  * [Tips](#tips)
    * [Enable GUI color in terminal vim](#enable-gui-color-in-terminal-vim)
    * [Font](#font)
* [Update](#update)
* [Contributions](#contributions)
* [Acknowledgements](#acknowledgements)
* [Articles](#articles)

<!-- vim-markdown-toc -->

## Introduction

space-vim is a vim distribution for vim plugins and resources, compatible with Vim and NeoVim.

It is inspired by [spacemacs](https://github.com/syl20bnr/spacemacs) and mimics spacemacs in a high level, especially in the whole architecture, key bindings and GUI. if have ever tried spacemacs, you will find space-vim is very similar to it in user experience.

Elegance here means pleasing, graceful as well as simple. If you are unfamiliar with spacemacs, you can visit [spacemacs.org](http://spacemacs.org/doc/DOCUMENTATION.html) for more about the priciple behind that, which is also what space-vim seeks.

The distribution is completely customizable using `.spacevim`, which is equivalent to `.spacemacs` in spacemacs.

![screenshot](https://raw.githubusercontent.com/liuchengxu/img/master/space-vim/space-vim-cterm.png)
(Terminal vim with [space-vim-dark](https://github.com/liuchengxu/space-vim-dark) theme)

## Features

- **Beautiful interface:** I have written a vim colorscheme [space-vim-dark](https://github.com/liuchengxu/space-vim-dark) based on spacemacs-dark theme. You could also try [spacemacs-theme.vim](https://github.com/colepeters/spacemacs-theme.vim).

    ![screenshot](https://raw.githubusercontent.com/liuchengxu/img/master/space-vim/space-vim-gui.png)
    (Terminal vim with `set termguicolors`)

- **Mnemonic key bindings:** commands have mnemonic prefixes like <kbd>SPC b</kbd> for all the buffer commands.

    Meanwhile, the whole key bindings have been well adapted for vim for the lack of great plugins similar to which-key in emacs. Most key bindings are limited to no more than two keystrokes without counting `<Leader>` or `<LocalLeader>` in, e.g. <kbd>SPC x d</kbd> to delete trailing whitespaces.

    For different language layers, `<LocalLeader>`, <kbd>,</kbd> as default in space-vim, can be seen as the major-mode prefix in spacemacs.

- **Lean and mean:** no nonsense wrappers, free from being bloated.

## For whom?

- the **novice** vim users
- the vimmers who pursuit a beautiful appearance
- the users **using both vim and spacemacs**

If you have been a vimmer for quite a while, just pick out the part you are interested in. space-vim is well-organized due to the layers concept, you can easily find what you want. Since some guys are interested in the statusline part of space-vim, this section has been extracted as [eleline.vim](https://github.com/liuchengxu/eleline.vim).

## Install

### Prerequisites

Make sure you have installed:

- **git**
- **Vim** or **NeoVim**

The most recent Vim(NeoVim) version is recommended.

:exclamation: ~~When layers enabled at the first time, you need to run `:PlugInstall` to install relevant plugins~~.

### Linux and macOS

#### one-line installer

```bash
$ bash <(curl -fsSL https://raw.githubusercontent.com/liuchengxu/space-vim/master/install.sh)
```
#### `Makefile`

```bash
$ git clone https://github.com/liuchengxu/space-vim.git ~/.space-vim
$ cd ~/.space-vim
$ make vim     # install space-vim for Vim
$ make neovim  # install space-vim for NeoVim
```

### Windows

1. [Download git](https://git-scm.com/download/win)

2. [Download Vim](https://github.com/vim/vim-win32-installer/releases)

3. Download [vim-plug](https://github.com/junegunn/vim-plug#installation):

    **windows (PowerShell)**

    ```powershell
    md ~\.vim\autoload
    $uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    (New-Object Net.WebClient).DownloadFile(
      $uri,
      $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
        "~\.vim\autoload\plug.vim"
      )
    )
    ```

4. Enter your home directory, Open *Git Bash* by right-clicking and choosing the option `Git Bash Here`.

    Run the following commands to download space-vim and make a symlink.

    ```bash
    $ git clone https://github.com/liuchengxu/space-vim.git ~/.space-vim
    $ ln -s ~/.space-vim/init.vim ~/.vimrc
    $ cp ~/.space-vim/init.spacevim ~/.spacevim
    ```

5. Open vim, run `:PlugInstall`.

### Manual (Linux and macOS)

1. Clone [space-vim](https://github.com/liuchengxu/space-vim)

    ```bash
    $ git clone https://github.com/liuchengxu/space-vim.git ~/.space-vim
    ```

2. Install [vim-plug](https://github.com/junegunn/vim-plug#installation), refer to vim-plug installation section for more information.

3. Create a symlink.

    ```bash
    # For Vim
    $ ln -s ~/.space-vim/init.vim ~/.vimrc

    # For NeoVim
    $ ln -s ~/.space-vim/init.vim ~/.config/nvim/init.vim

    # Both for Vim and NeoVim
    $ cp ~/.space-vim/init.spacevim ~/.spacevim
    ```
5. Open vim, then space-vim will automatically install the missing plugins in enabled layers. If auto-installation fails unexpectly, please try running `:PlugInstall` manually.

## Customize

You can use `.spacevim` in your home directory to customize space-vim, where you can enable the existing layers, add your extra plugins and private configurations.

If `.spacevim` does not exist, vanilla vim will be loaded! Refer to [init.spacevim](init.spacevim) as an example.

### Presetting

```vim
" Let Vim and NeoVim shares the same plugin directory
let g:spacevim_plug_home = '~/.vim/plugged'

" Change the background color of theme space-vim-dark (default 235)
let g:space_vim_dark_background = 234
```

### `Layers()`

Please refer to [LAYERS.md](layers/LAYERS.md) to take a look at the whole shipped layers.

```vim
" Enable the existing layers in space-vim
function! Layers()

  " Default layers
  Layer 'fzf'
  Layer 'unite'
  Layer 'better-defaults'

endfunction
```

### `UserInit()`

```vim
" Add your own plugins
function! UserInit()

  " The default leader key is space key.
  " Uncomment the line below and modify "<\Space>" if you prefer another
  " let g:spacevim_leader = "<\Space>"

  " The default local leader key is comma.
  " Uncomment the line below and modify ',' if you prefer another
  " let g:spacevim_localleader = ','

  " Install personal plugins
  " Plug 'hecal3/vim-leader-guide'

endfunction
```

### `UserConfig()`

```vim
" Override the default settings as well as adding extras
function! UserConfig()

  " If you have installed the powerline fonts and want to enable airline layer
  " let g:airline_powerline_fonts=1

  " Use gui colors in terminal if available
  if has('termguicolors')
    set termguicolors
    if g:spacevim_tmux
      " If use vim inside tmux, see https://github.com/vim/vim/issues/993
      " set Vim-specific sequences for RGB colors
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
  endif

endfunction
```

If have a heavy customized configuration, you can organize them in *private* directory with `packages.vim` and `config.vim` too, which will be loaded on startup. The *private* directory can be considered as either a single layer, i.e., in which you can put packages.vim and config.vim, or a set of multiple layers.

## How to use

First of all, I recommend you to look through the existing key bindings via <kbd>SPC ?</kbd>. What's more, you definitely can not miss reading the README of [better-defaults layer](https://github.com/liuchengxu/space-vim/blob/master/layers/%2Bdistributions/better-defaults/README.md), which is of great importance for you to get started quickly.

For detailed instruction, please refer to the README under the certain layer enabled, or you can see config.vim and packages.vim directly.

If the README is not elaborate, sorry for that, space-vim now is in the early stages and a ton of stuff are waiting to be done.

### Bootstrap

The modular design is originally from [spacemacs](https://github.com/syl20bnr/spacemacs). The implementation of logic in space-vim is similar to [vim-plug](https://github.com/junegunn/vim-plug).

If you want to know more about the bootstrap of space-vim, please see [bootstrap](https://github.com/liuchengxu/space-vim/wiki/Bootstrap) in wiki.

### Commands

 Command      | Description
 :---         | :---
`LayerStatus` | Check the status of layers
`LayerCache`  | Cache the information of *layers* in `info.vim`

### Tips

For the sake of a better user experience, some extra settings should be done.

#### Enable GUI color in terminal vim

`echo has('termguicolors')`, if `1`, then you can enable GUI color in terminal vim, add this to `UserConfig()`:

```vim
set termguicolors

" If you use vim inside tmux, see https://github.com/vim/vim/issues/993
" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
```

For more details about true colour, please see the gist [TrueColour.md](https://gist.github.com/XVilka/8346728).

#### Font

Install the [Source Code Pro](https://github.com/adobe-fonts/source-code-pro) or [Powerline](https://github.com/powerline/fonts) font, especially for [airline](https://github.com/liuchengxu/space-vim/blob/master/layers/%2Bthemes/airline/README.md) Layer.

If you are running in terminal you'll need to change font settings of your terminal as well.

![iterm2_font_setting](https://github.com/liuchengxu/space-vim/blob/gh-pages/docs/img/iterm2_powerline_setting.png?raw=true)

## Update

Run `make update`:

```bash
$ cd path/to/space-vim
$ make update
```

Alternatively, you can manually perform the following steps. If anything has changed with the structure of the configuration, you will have to create the appropriate symlinks.

```bash
$ cd path/to/space-vim
$ git pull origin master
```
## Contributions

If you encounter any problem or have any suggestions, please [open an issue](https://github.com/liuchengxu/space-vim/issues/new) or [send a PR](https://github.com/liuchengxu/space-vim/pulls).

Space-vim is still in beta. If you are interested, contributions are highly welcome.

## Acknowledgements

I would like to thank the many people who have helped and contributed to this project. What's more, space-vim would never have become what it is now, without the help of these projects!

- [spacemacs](https://github.com/syl20bnr/spacemacs)
- [vim-plug](https://github.com/junegunn/vim-plug)
- [spf13-vim](https://github.com/spf13/spf13-vim)

## Articles

- [Use Vim as a Python IDE](http://www.liuchengxu.org/posts/use-vim-as-a-python-ide/)
- [A Vim Configuration for Spacemacs User](http://www.liuchengxu.org/posts/space-vim/)
- [用 Vim 写 Python 的最佳实践](https://www.v2ex.com/t/337102#reply61)
- [手工制作一个漂亮的 vim statusline ](https://segmentfault.com/a/1190000007939244)
