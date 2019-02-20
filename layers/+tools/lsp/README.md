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
  * [Haskell](#haskell)
  * [Lua](#lua)
  * [vue](#vue)
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

If you run into this error on macOS, refer to [Fixing npm On Mac OS X for Homebrew Users](https://gist.github.com/DanHerbert/9520689).

```
[Error] [tsserver] /bin/sh: /usr/local/Cellar/node/10.11.0/bin/npm: No such file or directory
```

Afterwards, if you still have the following issue:

```
/bin/sh: /usr/local/Cellar/node/10.11.0/bin/npm: No such file or directory
```

try this solution:

```bash
$ which npm
/Users/xlc/.npm-packages/bin/npm
$ ln -s $(which npm) /usr/local/Cellar/node/10.11.0/bin/
```

### Haskell

[Haskell Language Server: haskell-ide-engine](https://github.com/haskell/haskell-ide-engine)

```bash
$ git clone https://github.com/haskell/haskell-ide-engine --recursive
$ cd haskell-ide-engine
$ stack install
```

### Lua

[Lua Language Server: lua-lsp](https://github.com/Alloyed/lua-lsp)

```bash
$ luarocks install --server=http://luarocks.org/dev lua-lsp
```

### vue

```bash
$ npm install vue-language-server -g
```

## Install

To use this configuration layer, add it to your `~/.spacevim`.

Currently, [LanguageClient-neovim](https://github.com/autozimu/LanguageClient-neovim) is the default LS client. To use [coc.nvim](https://github.com/neoclide/coc.nvim) instead:

```vim
let g:spacevim_lsp_engine = 'coc'
```

## Key Bindings

Key Binding        | Mode   | Description
:---:              | :---:  | :---:
`gd`               | Normal | go to definition

## Related Projects

- [LanguageClient-neovim](https://github.com/autozimu/LanguageClient-neovim)
- [vim-lsp](https://github.com/prabirshrestha/vim-lsp)
- [coc.nvim](https://github.com/neoclide/coc.nvim)
