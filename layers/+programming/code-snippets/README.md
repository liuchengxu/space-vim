# code-snippets layer

## Table of Contents

<!-- vim-markdown-toc GFM -->

* [Description](#description)
* [Install](#install)
* [Usage](#usage)
  * [Snippet Expand Trigger](#snippet-expand-trigger)
* [Related projects](#related-projects)

<!-- vim-markdown-toc -->

## Description

This layer adds support for code snippets.

## Install

To use this configuration layer, add it to your `~/.spacevim`.

## Usage

Better to use with completion layer together, e.g., `auto-completion` and `ycmd`.

### Snippet Expand Trigger

If no completion plugin or `ycmd` is enabled, the snippet expand trigger is `<C-e>`.

When `ncm2` is avalible, the snippet expand trigger is `<CR>`.

Check it via `:echo g:UltiSnipsExpandTrigger`.

## Related projects

- [SimpleSnippets](https://github.com/andreyorst/SimpleSnippets.vim)
- [vim-minisnip](https://github.com/KeyboardFire/vim-minisnip)
- [neosnippet.vim](Shougo/neosnippet.vim)
- [ultisnips](https://github.com/SirVer/ultisnips)
