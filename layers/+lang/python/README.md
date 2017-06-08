# Python layer

## Table of Contents

<!-- vim-markdown-toc GFM -->
* [Description](#description)
* [Install](#install)
    * [Layer](#layer)
    * [Dependencies](#dependencies)
        * [Auto-completion](#auto-completion)
        * [Syntax checking](#syntax-checking)
* [Key Bindings](#key-bindings)

<!-- vim-markdown-toc -->

## Description

This layer adds support for the Python language.

## Install

### Layer

To use this configuration layer, add it to your `~/.spacevim`.

### Dependencies

#### Auto-completion

`ycmd` layer recommended.

#### Syntax checking

`syntax-checking` layer needed. Syntax checking uses `flake8` package:

```sh
pip install flake8
```

## Key Bindings

Key Binding    | Mode   | Description
:---:          | :---:  | :---:
<kbd>F5</kbd>  | Normal | Execute current file
<kbd>, =</kbd> | Normal | Reformat the buffer according to PEP8 using [YAPF](https://github.com/google/yapf)
