# Vimwiki

## Table of Contents

<!-- vim-markdown-toc GFM -->
* [Description](#description)
* [Install](#install)
* [Key Bindings](#key-bindings)

<!-- vim-markdown-toc -->

## Description

This layer adds Vimwiki. Learn more at http://vimwiki.github.io/

## Quick start

You'll need to configure at least one wiki in your ~/.spacevim. For example:

```
let g:vimwiki_list = [{'path': '~/Documents/wikis/ericwiki/',
											\ 'syntax': 'markdown', 'ext': '.md',
											\ 'custom_wiki2html': 'wiki2html',
											\ 'path_html': '~/Sites/Notes/',
											\ 'diary_rel_path': 'Journal/'
											\ },
											\{'path': '~/Documents/wikis/feels/',
											\ 'syntax': 'markdown', 'ext': '.md',
											\ 'custom_wiki2html': 'wiki2html',
											\ 'diary_rel_path': 'Journal/'
											\ }]
```

## Key Bindings

Key Binding        | Mode   | Description
:---:              | :---:  | :---:
<kbd>SPC W w</kbd> | Normal | Wiki index
