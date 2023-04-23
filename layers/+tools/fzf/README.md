# fzf layer

## Table of Contents

<!-- TOC GFM -->

* [Description](#description)
* [Prerequisite](#prerequisite)
* [Install](#install)
* [Key Bindings](#key-bindings)
* [Related Projects](#related-projects)

<!-- /TOC -->

## Description

This layer adds supports fuzzy file finder as well as much more other functionalities.

## Prerequisite

This layer depends on [fzf](https://github.com/junegunn/fzf). For macOS and Linux users, it will be installed automatically. If you are using Windows, I recommend you install fzf via [chocolatey](https://chocolatey.org/).

```
choco install fzf

choco install ag
choco install ripgrep
```

Alternatively ripgrep, fd, git-delta, bat will be built from source if using the 'rustc' layer. fzf and ag are not rust and can't be built with the 'rustc' layer.

## Install

To use this configuration layer, add it to your `~/.spacevim`. *It has been enabled as one of the default layers*.

## Key Bindings

Key Binding        | Mode    | Description
:---:              | :---:   | :---:
<kbd>SPC ?</kbd>   | Normal  | show normal mode maps
<kbd>SPC b b</kbd> | Normal  | buffers list
<kbd>SPC b ?</kbd> | Normal  | buffers list
<kbd>SPC w ?</kbd> | Normal  | windows list
<kbd>SPC f ?</kbd> | Normal  | search files in current directory
<kbd>SPC f f</kbd> | Normal  | search files in home directory
<kbd>\<C-R></kbd>  | Cmdline | search command history

press <kbd>\<esc></kbd>, <kbd>Ctrl c</kbd> or <kbd>Ctrl [</kbd> to exit.

<kbd>\<C-R></kbd> in command-line-mode mimics the same hotkey in bash. Unfortunately this keymap replaces the `c_CTRL-R` register paste, but can be worked around using `c_CTRL-\_e @<register>`. See `:help c_CTRL-\_e`.

## Related Projects

- [fzy-vim](https://github.com/Dkendal/fzy-vim)
- [scout.vim](https://github.com/jhbabon/scout.vim)
- [vim-picker](https://github.com/srstevenson/vim-picker)
- [neovim-fuzzy](https://github.com/cloudhead/neovim-fuzzy)
- [vim-fz](https://github.com/mattn/vim-fz)
- [quickpick.vim](https://github.com/prabirshrestha/quickpick.vim)
- [probe](https://github.com/torbiak/probe)
