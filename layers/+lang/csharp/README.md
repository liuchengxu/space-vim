# C# Layer

## Table of Contents

<!-- vim-markdown-toc GFM -->
* [Description](#description)
* [Install](#install)
* [Key Bindings](#keybindings)

<!-- vim-markdown-toc -->

## Description

This layer adds support for the C# language.

## Install

To use this configuration layer, add it to your `.spacevim`.

## Key Bindings

Here are most/all:

```vim
let g:OmniSharp_popup_mappings = {
\ 'close': ['<Esc>', 'gq']
\ 'lineDown': '<C-e>',
\ 'lineUp': '<C-y>',
\ 'halfPageDown': '<C-d>',
\ 'halfPageUp': '<C-u>',
\ 'pageDown': ['<C-f>', '<PageDown>'],
\ 'pageUp': ['<C-b>', '<PageUp>']
\ 'sigNext': '<C-j>',
\ 'sigPrev': '<C-k>',
\ 'sigParamNext': '<C-l>',
\ 'sigParamPrev': '<C-h>'
\}

nmap <C-\> <Plug>(omnisharp_signature_help)
imap <C-\> <Plug>(omnisharp_signature_help)
nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
"nmap <prefix>ca <Plug>(omnisharp_code_actions)
"xmap <prefix>ca <Plug>(omnisharp_code_actions)
"nmap <silent> <buffer> <prefix>. <Plug>(omnisharp_code_action_repeat)
"xmap <silent> <buffer> <prefix>. <Plug>(omnisharp_code_action_repeat)
```

The remainder are integrated with *vim-which-key* in the `<leader>/+lsp` category.

See [OmniSharp/omnisharp-vim](https://github.com/OmniSharp/omnisharp-vim) for some bindings documentation. See `:help omnisharp`.
[nickspoons/vim-sharpenup](https://github.com/nickspoons/vim-sharpenup) includes some keybindings but they are not enabled and were instead integrated with *space-vim* and *vim-which-key*.
