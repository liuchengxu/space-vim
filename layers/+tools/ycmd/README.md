# Ycmd layer

## Table of Contents

<!-- vim-markdown-toc GFM -->

* [Description](#description)
* [Install](#install)
* [Install Notification](#install-notification)
* [Key Bindings](#key-bindings)

<!-- vim-markdown-toc -->

## Description

This layer adds support for a code completion engine.

## Install

To use this configuration layer, add it to your `~/.spacevim`.

## Install Notification
Regard of the complexity of installing this plugin,you may find the **ycmd** can't work properly as your expect,then you need to manually compile it.(All these steps have been tested and passed on the **ubuntu 16.04**,if you are working on other operation system or need more infomation please visit [YouCompleteMe](https://github.com/Valloric/YouCompleteMe).)

**Step 1.**
Get into the folder of *YouCompleteMe*.(Note: If you don't have this folder means you haven't downloaded the plugin,so you should download it first by adding `Layer 'ycmd'` to  `~/.spacevim` )

```sh
# For vim
cd ~/.vim/plugged/YouCompleteMe
# For neovim
cd ~/.local/share/nvim/plugged/YouCompleteMe
```

**Step 2.**
Do the advanced-installation.

```sh
# Install development tools and CMake
sudo apt-get install build-essential cmake
# Make sure you have Python headers installed
sudo apt-get install python-dev python3-dev
```
**Step 3.**
After confirming that you have excuted(or satisfied with the requirement of) all the steps above,now you can compile the YouCompleteMe with semantic support for C-family languages.

```sh
./install.py --clang-completer
```

## Key Bindings

- Use `tab` and `Shift-tab` to rotate through the candidates.

- `<C-j>` and `<C-k>` also circles through the candidates, but you need to press `<CR>` to really insert the completion item.
