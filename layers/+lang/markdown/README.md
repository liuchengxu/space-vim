# Markdown layer

## Table of Contents

<!-- vim-markdown-toc GFM -->
* [Description](#description)
* [Install](#install)
* [Key Bindings](#key-bindings)

<!-- vim-markdown-toc -->

## Description

This layer adds support the markdown language.

## Install

To use this configuration layer, add it to your `~/.spacevim`.

## Key Bindings

Key Binding      | Mode   | Description
:---:            | :---:  | :---:
<kbd>, c p</kbd> | Normal | markdown preview (require chrome in linux and windows ,require safari in MacOS)
<kbd>, c t</kbd> | Normal | Generate Toc
<kbd>, c s</kbd> | Normal | Show Toc sidebar
<kbd>, 1</kbd>   | Normal | heading level 1
<kbd>, 2</kbd>   | Normal | heading level 2
<kbd>, 3</kbd>   | Normal | heading level 3
<kbd>, 4</kbd>   | Normal | heading level 4
<kbd>, 5</kbd>   | Normal | heading level 5

The preview functionality is supported by [vim-Xmark](https://github.com/junegunn/vim-xmark), which requires homebrew and google chrome.

## Related Projects

- [vim-markdown-composer](https://github.com/euclio/vim-markdown-composer)
