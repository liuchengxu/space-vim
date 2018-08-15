# Haskell layer

## Table of Contents

<!-- vim-markdown-toc GFM -->

* [Description](#description)
* [Install](#install)
* [Requirement](#requirement)
  * [macOS](#macos)
  * [LSP](#lsp)
* [Key Bindings](#key-bindings)

<!-- vim-markdown-toc -->

## Description

This layer adds support for the Haskell language.

## Install

To use this configuration layer, add it to your `~/.spacevim`.

## Requirement

### macOS

```bash
$ brew install haskell-stack
```

### LSP

```bash
$ git clone https://github.com/haskell/haskell-ide-engine --recursive
$ cd haskell-ide-engine
$ stack install
```

Refer to https://github.com/haskell/haskell-ide-engine for more information.

## Key Bindings

Key Binding    | Mode   | Description
:---:          | :---:  | :---:
