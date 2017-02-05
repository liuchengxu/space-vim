# tmux layer

## Table of Contents

<!-- vim-markdown-toc GFM -->
* [Description](#description)
* [Install](#install)
* [Key Bindings](#key-bindings)
* [tmux config](#tmux-config)
	* [Add a snippet](#add-a-snippet)
	* [TPM](#tpm)

<!-- vim-markdown-toc -->

## Description

This layer adds supports tmux operation.

## Install

To use this configuration layer, add it to your `~/.spacevim`.

## Key Bindings

Key Binding        | Mode   | Description
:---:              | :---:  | :---:
<kbd>SPC m b</kbd> | Normal | Sends ctrl+c to the associated pane.
<kbd>SPC m c</kbd> | Normal | Sends ctrl+l to the associated pane.
<kbd>SPC m d</kbd> | Normal | fuzzy search tmux command and execute without argument
<kbd>SPC m f</kbd> | Normal | fuzzy search tmux copied buffer
<kbd>SPC m i</kbd> | Normal | fuzzy search tmux command and ask for argument
<kbd>SPC m k</kbd> | Normal | Prompts for input and sends it to the associated pane as
<kbd>SPC m m</kbd> | Normal | fuzzy search tmux  sessions
<kbd>SPC m n</kbd> | Normal | create a new tmux pane
<kbd>SPC m p</kbd> | Normal | Associate an already existing pane with tmuxify.
<kbd>SPC m q</kbd> | Normal | Closes the associated pane.
<kbd>SPC m r</kbd> | Normal | Run external command in a new tmux pane
<kbd>SPC m s</kbd> | Normal | Prompts for input and sends it to the associated pane.
<kbd>SPC m t</kbd> | Normal | Change the run command for the current filetype.
<kbd>SPC m w</kbd> | Normal | fuzzy search tmux  windows
<kbd>Ctrl h</kbd>  | Normal | TmuxNavigateRight
<kbd>Ctrl l</kbd>  | Normal | TmuxNavigateLeft
<kbd>Ctrl j</kbd>  | Normal | TmuxNavigateDown
<kbd>Ctrl k</kbd>  | Normal | TmuxNavigateUp


## tmux config

To configure the tmux side of this customization there are two options:

### Add a snippet

Add the following to your `~/.tmux.conf` file:

``` tmux
# Smart pane switching with awareness of Vim splits.
# See: https://github.com/christoomey/vim-tmux-navigator
is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
bind-key -n C-h if-shell "$is_vim" "send-keys C-h"  "select-pane -L"
bind-key -n C-j if-shell "$is_vim" "send-keys C-j"  "select-pane -D"
bind-key -n C-k if-shell "$is_vim" "send-keys C-k"  "select-pane -U"
bind-key -n C-l if-shell "$is_vim" "send-keys C-l"  "select-pane -R"
bind-key -n C-\ if-shell "$is_vim" "send-keys C-\\" "select-pane -l"
```

### TPM

If you'd prefer, you can use the Tmux Plugin Manager ([TPM][https://github.com/tmux-plugins/tpm]) instead of
copying the snippet.
When using TPM, add the following lines to your ~/.tmux.conf:

``` tmux
set -g @plugin 'christoomey/vim-tmux-navigator'
run '~/.tmux/plugins/tpm/tpm'
```

Thanks to Christopher Sexton who provided the updated tmux configuration in
[this blog post][http://www.codeography.com/2013/06/19/navigating-vim-and-tmux-splits].
