# nodejs tool Layer

## Table of Contents

<!-- vim-markdown-toc GFM -->
* [Description](#description)
* [Install](#install)
  * [Building](#building)
    * [MS Windows](#ms-windows)

<!-- vim-markdown-toc -->

## Description

Folowing the zero-install philosophy, this layer adds the Node.js tool, built from source if needed.

If `node` is found on $PATH, or $NODE points to `node`, and either is of sufficient version, that will be used instead of building from source.

The curated node will be added to `$PATH` for use by other plugins and language servers. Including yarn/npm which language servers may use to download dependencies.

## Install

To use this layer, add it to your `~/.spacevim`.

### Building

On building from source, around 200MiB is installed into the prefix `./install` relative to the plugin directory. The building process requires around 4GiB, which will be deleted on completion.

If the automated building doesn't work, you may navigate to the plugin directory and build manually, into the prefix `./install`; installing system-wide isn't required. Or install prebuilt binaries and set $PATH or $NODE accordingly.

#### MS Windows

You have two ABI choices: GNU and MSVC (comes with Visual Studio Tools). Your choice depends on the C/C++ libraries you want to interoperate with.

Automated building from source isn't tested. However it should work in Cygwin or with the environmental variables as defined by `msys2_shell.cmd` or `vcvars64.bat` per the desired ABI.
