<p align="left">
<a href="https://github.com/liuchengxu/space-vim"> <img src="https://rawgit.com/liuchengxu/space-vim/master/assets/space-vim-badge.svg" alt="badge"></a>
<a href="https://github.com/liuchengxu/space-vim/blob/master/LICENSE"><img src="https://rawgit.com/liuchengxu/space-vim/master/assets/license.svg" alt="license"></a>
<a href="https://github.com/liuchengxu/space-vim/actions?workflow=ci"><img src="https://github.com/liuchengxu/space-vim/workflows/ci/badge.svg" alt="CI"></a>
</p>

--------------------

<p align="center"><img src="https://raw.githubusercontent.com/liuchengxu/space-vim/gh-pages/docs/img/space-vim.png" alt="space-vim"/></p>

### Table of Contents

<!-- vim-markdown-toc GFM -->

* [Introduction](#introduction)
* [Features](#features)
* [For whom?](#for-whom)
* [Install](#install)
    * [Prerequisites](#prerequisites)
    * [Linux and macOS](#linux-and-macos)
        * [one-line installer](#one-line-installer)
        * [Makefile](#makefile)
    * [Windows](#windows)
    * [Manual](#manual)
* [Customize](#customize)
    * [Presetting](#presetting)
    * [`UserInit()`](#userinit)
    * [`UserConfig()`](#userconfig)
* [How to use](#how-to-use)
    * [Bootstrap](#bootstrap)
    * [Commands](#commands)
    * [Tips](#tips)
        * [Enable GUI color in terminal vim](#enable-gui-color-in-terminal-vim)
        * [Font](#font)
            * [GUI](#gui)
            * [Terminal](#terminal)
* [Update](#update)
* [Contributions](#contributions)
* [Acknowledgements](#acknowledgements)
* [Articles](#articles)
* [Contributors](#contributors)

<!-- vim-markdown-toc -->

## Introduction

space-vim is a vim distribution for vim plugins and resources, compatible with Vim and NeoVim.

It is inspired by [spacemacs](https://github.com/syl20bnr/spacemacs) and mimics spacemacs in a high level, especially in the whole architecture, key bindings and GUI. if have ever tried spacemacs, you will find space-vim is very similar to it in user experience.

Elegance here means pleasing, graceful as well as simple. If you are unfamiliar with spacemacs, you can visit [spacemacs.org](http://spacemacs.org/doc/DOCUMENTATION.html) for more about the principle behind that, which is also what space-vim seeks.

The distribution is completely customizable using `.spacevim`, which is equivalent to `.spacemacs` in spacemacs.

![screenshot](https://raw.githubusercontent.com/liuchengxu/img/master/space-vim/space-vim-gui.png)
(Terminal vim with [space-vim-dark](https://github.com/liuchengxu/space-vim-dark))

[>> More screenshots](https://github.com/liuchengxu/space-vim/wiki/screenshots)

## Features

- **Beautiful interface:** I wrote a dark only vim colorscheme [space-vim-dark](https://github.com/liuchengxu/space-vim-dark) based on the dark version of spacemacs-theme previously. Now we have a new option: [space-vim-theme](https://github.com/liuchengxu/space-vim-theme), which is the successor of space-vim-dark that supports both dark and light background!

  <p align="center">
    <img width="400px" height="300px" src="https://raw.githubusercontent.com/liuchengxu/img/master/space-vim-theme/light.png">
  </p>

- **Mnemonic key bindings:** commands have mnemonic prefixes like <kbd>SPC b</kbd> for all the buffer commands, this feature is mainly powered by [vim-which-key](https://github.com/liuchengxu/vim-which-key). Furthermore, lots of basic key bindings are provided by [vim-better-default](https://github.com/liuchengxu/vim-better-default). For different language layers, `<LocalLeader>`, <kbd>,</kbd> as default in space-vim, can be seen as the major-mode prefix in spacemacs.

<p align="center"><img width="800px" src="https://user-images.githubusercontent.com/8850248/46784654-8e6f9800-cd61-11e8-88df-673ff5826981.png"></p>

- **Lean and mean:** no nonsense wrappers, free from being bloated.

## For whom?

- the **novice** vim users
- the vimmers who pursuit a beautiful appearance
- the users **using both vim and spacemacs**

Have a look at the [Introduction](https://github.com/liuchengxu/space-vim/wiki/Introduction) in wiki as well.

If you have been a vimmer for quite a while, just pick out the part you are interested in. space-vim is well-organized due to the layers concept, you can easily find what you want. Since some guys are interested in the statusline part of space-vim, this section has been extracted as [eleline.vim](https://github.com/liuchengxu/eleline.vim).

## Install

### Prerequisites

The most recent Vim(NeoVim) version is recommended.

space-vim aspires to adhere to the zero-install philosophy, just clone and use. Optional dependencies not installed on the system are downloaded and built from source where possible, and are used embedded within the application.

> In order to make a project zero-install, you must be able to use it as soon as you clone it.

At present there is a lack of the above dependency build feature on Windows. [chocolatey](https://chocolatey.org/) is an easy way to install software on Windows, tools like `fzf`, `rg`, `ag`, `rustc`, `cargo`, `npm` are necessary to get you a full-featured space-vim.

### Install location

Installing space-vim to the conventional Vim/Neovim install location mitigates the need for an extra symlink to where space-vim is installed. `/path/to/space-vim` may be `~/.vim` (Vim), `~/.config/nvіm` (Neovim), or elsewhere.

### Clone

1. Clone [space-vim](https://github.com/liuchengxu/space-vim):


    ```bash
    $ git clone https://github.com/liuchengxu/space-vim.git --single-branch /path/to/space-vim
    ```

2. Create the symlink(s):

    **Linux and macOS**

    ```bash
    # **For Vim**
    # If space-vim not installed to ~/.vim/:
    $ ln -s /path/to/space-vim/init.vim ~/.vimrc

    # **For NeoVim**
    # If space-vim not installed to ~/.config/nvim/:
    $ ln -s /path/to/space-vim/init.vim ~/.config/nvim/init.vim



## Customize

    ```bash
    # Copy init.spacevim for local customization, or symlink it
    $ cp /path/to/space-vim/init.spacevim ~/.spacevim
    ```

You can use `.spacevim` in your home directory to customize space-vim, where you can enable the existing layers, add your extra plugins and private configurations.

### .spacevim details

Please refer to [LAYERS.md](layers/LAYERS.md) to take a look at the whole shipped layers.

Basically, `g:spacevim_layers` almost takes the place of `Layer` command. As far as I known, most people never use the option of `Layer` command, e.g., `exclude`, so `g:spacevim_layers` could save a lengthy `Layer` list, requiring less ceremony. Nevertheless, `Layer` command is still avaiable for some advanced uses.

### `UserInit()`

`UserInit()` may be used to add plugins that are not within a layer.

```vim
" Manage your own plugins.
" Refer to https://github.com/Shougo/dein.vim for more detials.
function! UserInit()

  " Add your own plugin via Plug command (wrapper around dein#add)
  Plug 'junegunn/seoul256.vim'

endfunction
```

### `UserConfig()`

Configuration may be placed in `UserConfig()`, and/or in a `plugin/` folder on the runtime path. E.g. `~/.vim/plugin/<pluginname>.vim` for each local plugin configuration.

```vim
" Override the default settings as well as adding extras
function! UserConfig()

  " Override the default settings.
  " Uncomment the following line to disable relative number.
  " set norelativenumber

  " Adding extras.
  " Uncomment the following line If you have installed the powerline fonts.
  " It is good for airline layer.
  " let g:airline_powerline_fonts = 1

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

- `:echo has('termguicolors')`, if `1`, then your vim supports true colors.
- See if your terminal-(emulator) supports true colors, refer to the gist [TrueColour.md](https://gist.github.com/XVilka/8346728).

If these two requirements are satisfied, you could enable true color by uncommenting the line:

```vim
" Uncomment the following line if your terminal(-emulator) supports true colors.
let g:spacevim_enable_true_color = 1
```

#### Font

Some fantastic fonts: [see wiki tips: programming-fonts](https://github.com/liuchengxu/space-vim/wiki/tips#programming-fonts).

##### GUI

For instance, install [Iosevka](https://github.com/be5invis/Iosevka) first and use it:

```vim
let &guifont = 'Iosevka:h16'
```

##### Terminal

<img src="https://github.com/liuchengxu/space-vim/blob/gh-pages/docs/img/iterm2_powerline_setting.png?raw=true" align="right" width="550px" alt="iterm2-font-setting" />

First, install the [Source Code Pro](https://github.com/adobe-fonts/source-code-pro) or [Powerline](https://github.com/powerline/fonts) font, which is important for [airline](https://github.com/liuchengxu/space-vim/blob/master/layers/%2Bthemes/airline/README.md) layer.

Second, since console Vim uses whatever font the console/terminal is using, you'll have to change the font setting of your terminal.

## Update

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
- [Vim 专题](https://www.jianshu.com/c/eb88e454b66a)

## Contributors

This project exists thanks to all the people who contribute.
<a href="https://github.com/liuchengxu/space-vim/graphs/contributors"><img src="https://opencollective.com/space-vim/contributors.svg?width=890&button=false" /></a>
