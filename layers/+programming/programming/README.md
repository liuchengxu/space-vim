# Programming layer

## Table of Contents

<!-- vim-markdown-toc GFM -->
* [Description](#description)
* [Install](#install)
* [Key Bindings](#key-bindings)
* [Tips](#tips)

<!-- vim-markdown-toc -->

## Description

This layer adds support for typical and basical functionalities for programming.

编程常用技能包。比如使用 vim 新建文件时自动添加文件头，快速注释等等。

## Install

To use this configuration layer, add it to your `~/.spacevim`.

## Key Bindings

Key Binding                        | Mode           | Description
:---:                              | :---:          | :---:
<kbd>SPC ; ;</kbd>                 | Normal, Visual | comment/uncomment automatically, 自动添加/取消注释
<kbd>SPC t i</kbd>                 | Normal         | toggle-indent-guide, 显示缩进对齐
<kbd>SPC t t</kbd> / <kbd>F6</kbd> | Normal         | toggle-tagbar, 打开 tagbar (也可记 tagbar 6个字符, 故为 F6)

## Tips

For <kbd>Alt j</kbd>, <kbd>Alt k</kbd>, <kbd>Alt h</kbd>, and <kbd>Alt l</kbd> (move line/selection down/up or move char left/right)supported by [vim-move](https://github.com/matze/vim-move), you need to configure your terminal and iterm, see [here](https://github.com/matze/vim-move/issues/15).

- In iTerm: Profiles -> Keys -> Left option key acts as: `+Esc`
- In Terminal: Profiles -> Keyboard -> `Use Option as Meta key`
