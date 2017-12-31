# Better-motion layer

## Table of Contents

<!-- vim-markdown-toc GFM -->
* [Description](#description)
* [Install](#install)
* [Key Bindings](#key-bindings)
* [Related Projects](#related-projects)

<!-- vim-markdown-toc -->

## Description

This layer adds support for efficient motion.

## Install

To use this configuration layer, add it to your `~/.spacevim`.

## Key Bindings

Key Binding          | Mode   | Description
:---:                | :---:  | :---:
<kbd>SPC j w         | Normal | 单词跳转 (jump to word)
<kbd>SPC j l         | Normal | 行间跳转 (jump to line)
<kbd>SPC j j         | Normal | goto-char, 单个字符搜索, 等同于<kbd>SPC SPC s</kbd>
<kbd>SPC j J         | Normal | goto-char-2, 两个字符搜索
<kbd>SPC SPC w</kbd> | Normal | 快速词间移动(向前)
<kbd>SPC SPC b</kbd> | Normal | 快速词间移动 (向后)
<kbd>SPC SPC s</kbd> | Normal | 快速字符搜索 (双向)
<kbd>SPC SPC f</kbd> | Normal | 快速字符搜索 (向前)
<kbd>SPC SPC j</kbd> | Normal | 快速行间移动 (向下)
<kbd>SPC SPC k</kbd> | Normal | 快速行间移动 (向上)

## Related Projects

- [vim-snipe](https://github.com/yangmillstheory/vim-snipe)
