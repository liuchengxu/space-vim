# lsp layer

## Table of Contents

<!-- vim-markdown-toc GFM -->

* [Description](#description)
* [Install](#install)
* [Manual Language Server Installation](#manual-language-server-installation)
  * [Rust](#rust)
  * [Python](#python)
  * [Go](#go)
  * [Bash](#bash)
  * [Typescript](#typescript)
  * [Haskell](#haskell)
  * [Lua](#lua)
  * [vue](#vue)
* [Key Bindings](#key-bindings)
* [Related Projects](#related-projects)

<!-- vim-markdown-toc -->

## Description

This layer adds supports [Language Server Protocol](https://langserver.org/).

## Install

To use this configuration layer, add it to your `~/.spacevim`, set it up like so:

```vim
let g:spacevim_layers = [
      \ 'lsp',
      \ ]
```

Currently [LanguageClient-neovim](https://github.com/autozimu/LanguageClient-neovim) is the default *language server client* when using the lsp layer.

Currently the *language server client* builtin to Neovim is not supported by space-vim [#483](https://github.com/liuchengxu/space-vim/issues/483).

To use [coc.nvim](https://github.com/neoclide/coc.nvim) or [vim-lsp](https://github.com/prabirshrestha/vim-lsp) instead of the default set `g:spacevim_lsp_engine` as desired:

```vim
let g:spacevim_layers = [
      \ 'lsp',
      \ ]

let g:spacevim_lsp_engine = 'coc'
let g:spacevim_lsp_engine = 'vim_lsp'
```

Note that coc.nvim is dependent on Node.js, the nodejs layer will satisfy that dependency.

If using vim-lsp as the *language server client*, this layer will handle the configuration and installation of many *language servers* for you (this layer includes the [vim-lsp-settings](https://github.com/mattn/vim-lsp-settings) plugin). On opening a file this layer will detect if there is a *language server* for that filetype and prompt you to run the command `:LspInstallServer`.

Unlike other Vim *language server clients*, LanguageClient-neovim does not include configuration and installation of *language servers*. space-vim includes some configuration for *language servers* and this client, but installation must be done manually.

Often the Yarn or npm tools are needed to retrieve a *language server* and its dependencies. For convenience space-vim includes these tools within the nodejs layer, which builds them or locates them using the `$PATH` and `$NODE` environmental variables. You may include the nodejs layer as follows (which may require the programming layer):

```vim
let g:spacevim_layers = [
      \ 'programming', 'nodejs', 'lsp',
      \ ]
```

## Manual Language Server Installation

If using LanguageClient-neovim, directions for the manual installation of some LSP servers are as follows. Other configuration and installation directions can be found in locations like its github wiki pages.

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

## Key Bindings

Key Binding        | Mode   | Description
:---:              | :---:  | :---:
`gd`               | Normal | go to definition

## Related Projects

- [LanguageClient-neovim](https://github.com/autozimu/LanguageClient-neovim)
- [vim-lsp](https://github.com/prabirshrestha/vim-lsp)
- [coc.nvim](https://github.com/neoclide/coc.nvim)
