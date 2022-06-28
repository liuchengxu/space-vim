# Rust tool layer

## Table of Contents

<!-- TOC GFM -->

* [Description](#description)
* [Install](#install)
  * [Building](#building)
     * [Prerequisite](#prerequisite)
     * [MS Windows](#ms-windows)

<!-- /TOC -->

## Description

Folowing the zero-install philosophy, this layer adds the Rust compiler, standard library, documentation, and default extensions including Cargo. All built from source.

If `rustc` is found on $PATH, or $RUSTC points to `rustc`, and either is of sufficient version, that will be used instead of building from source.

Cargo will be added to $PATH for use by Vim plugins and for a LSP plugin/engine to install language servers.

A convenience feature of this layer is that the binaries installed by cargo will be added to $PATH, e.g. deno, tree-sitter, and language servers.

## Install

To use this layer, add it to your `~/.spacevim`.

### Building

On building from source, around 600MiB is іnstalled into the prefix `./install` relative to the plugin directory. The building process requires around 17GiB, which will be deleted on completion.

If the automated building doesn't work, you may navigate to the plugin directory and build manually, into the prefix `./install`; installing system-wide isn't required. Or install prebuilt binaries and set $PATH or $RUSTC accordingly.

#### Prerequisite

See [Unix](https://github.com/rust-lang/rust#building-on-a-unix-like-system) or [Windows](https://github.com/rust-lang/rust#building-on-windows) prerequisites.

#### MS Windows

At present rust supports building under two ABIs: GNU and MSVC (comes with Visual Studio Tools). Your choice depends on the C/C++ libraries you want to interoperate with.

Automated building from source isn't tested. However it should work in Cygwin or with the environmental variables as defined by `msys2_shell.cmd` or `vcvars64.bat` per the desired ABI.
