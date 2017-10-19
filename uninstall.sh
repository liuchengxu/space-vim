#!/usr/bin/env bash

confirm() {
  while true; do
    read -p "$1" -n 1 -r
    echo
    if [[ "$REPLY" =~ ^[Yy] ]]; then
      return 0
    elif [[ "$REPLY" =~ ^[Nn] ]]; then
      return 1
    fi
  done
}

uninstall() {
  rm -f "$HOME/.vimrc"
  rm -f "$HOME/.config/nvim/init.vim"
  rm -f "$HOME/.spacevim"
  rm -rf "$HOME/.space-vim"
}

if confirm "    - Uninstall (y/n) ? "; then
  uninstall
  echo  "      - Uninstalled"
else
  echo  "      - Skipped"
fi
