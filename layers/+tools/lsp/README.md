# lsp layer

## Table of Contents

<!-- vim-markdown-toc GFM -->

* [Description](#description)
* [Requrement](#requrement)
  * [Rust](#rust)
  * [Python](#python)
  * [Go](#go)
  * [Bash](#bash)
  * [Typescript](#typescript)
* [Install](#install)
* [Key Bindings](#key-bindings)
* [Related Projects](#related-projects)

<!-- vim-markdown-toc -->

## Description

This layer adds supports [Language Server Protocol](https://langserver.org/).

## Requrement

### Rust

[Rust Language Server: rls](https://github.com/rust-lang-nursery/rls)

```bash
$ rustup default nightly
$ rustup update
$ rustup component add rls-preview rust-analysis rust-src
```

### Python

[Python Language Server: pyls](https://github.com/palantir/python-language-server)

```bash
pip install 'python-language-server[all]'
```

### Go

[Go Language Server: go-langserver](https://github.com/sourcegraph/go-langserver)

```bash
$ go get -u github.com/sourcegraph/go-langserver
```

### Bash

[Bash Language Server: bash-language-server](https://github.com/mads-hartmann/bash-language-server)

```bash
# npm
$ npm i -g bash-language-server

# yarn
$ yarn global add bash-language-server
```

### Typescript

[Typescript Language Server: typescript-language-server](https://github.com/theia-ide/typescript-language-server)

```bash
# npm
$ npm install -g typescript-language-server

# yarn
$ yarn global add typescript-language-server
```

## Install

To use this configuration layer, add it to your `~/.spacevim`.

## Key Bindings

Key Binding        | Mode   | Description
:---:              | :---:  | :---:
`gd`               | Normal | go to definition

## Related Projects

- [LanguageClient-neovim](https://github.com/autozimu/LanguageClient-neovim)
- [vim-lsp](https://github.com/prabirshrestha/vim-lsp)
