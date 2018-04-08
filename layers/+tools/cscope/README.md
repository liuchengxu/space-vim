# cscope layer

## Table of Contents

<!-- vim-markdown-toc GFM -->

* [Description](#description)
* [Install](#install)
* [Key Bindings](#key-bindings)
* [Tips](#tips)

<!-- vim-markdown-toc -->

## Description

This layer adds supports for cscope.

## Install

To use this configuration layer, add it to your `~/.spacevim`.

## Key Bindings

Key Binding        | Mode   | Description
:---:              | :---:  | :---:
<kbd>SPC c s</kbd> | Normal | find all references to the token under cursor
<kbd>SPC c g</kbd> | Normal | find global definition(s) of the token under cursor
<kbd>SPC c c</kbd> | Normal | find all calls to the function name under cursor
<kbd>SPC c t</kbd> | Normal | find all instances of the text under cursor
<kbd>SPC c e</kbd> | Normal | egrep search for the word under cursor
<kbd>SPC c f</kbd> | Normal | open the filename under cursor
<kbd>SPC c i</kbd> | Normal | find files that include the filename under cursor
<kbd>SPC c d</kbd> | Normal | find functions that function under cursor calls

## Tips

Use `:cc 2` (or any other number) to jump to, in this case, the second error in the quickfix window.

Put these settings in `UserConfig()` to configure cscope automatically when editing related files.

```vim
autocmd BufNewFile,BufRead *.c,*.h,*.hpp,*.cpp call spacevim#vim#cscope#Build()
autocmd BufNewFile,BufWritePost *.c,*.h,*.hpp,*.cpp call spacevim#vim#cscope#UpdateDB()
```
