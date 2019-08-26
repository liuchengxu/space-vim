#!/usr/bin/env bash
#
#                                        _
#    ___ _ __   __ _  ___ ___     __   _(_)_ __ ___
#   / __| -_ \ / _- |/ __/ _ \____\ \ / / | -_ - _ \
#   \__ \ |_) | (_| | (_|  __/_____\ V /| | | | | | |
#   |___/ .__/ \__._|\___\___|      \_/ |_|_| |_| |_|
#       |_|
#

set -eo pipefail

app_name="space-vim"
repo_uri="https://github.com/liuchengxu/space-vim.git"
repo_name="space-vim"
repo_path="$HOME/.space-vim"
repo_branch="master"
_all=
_vim=
_neovim=
_update=

help() {
  cat << EOF
usage: $0 [OPTIONS]

    --help               Show this message
    --all                Install space-vim for Vim and NeoVim
    --vim                Install space-vim for Vim
    --neovim             Install space-vim for NeoVim
    --update             Update space-vim
EOF
}

for opt in "$@"; do
  case $opt in
    --help)
      help
      exit 0
      ;;
    --all)           _all=1    ;;
    --vim)           _vim=1    ;;
    --neovim)        _neovim=1 ;;
    --update)        _update=1 ;;
    *)
      echo "unknown option: $opt"
      help
      exit 1
      ;;
  esac
done

###############################
## Basic tools
###############################
msg() {
  printf '%b\n' "$1" >&2
}

success() {
  if [ "$ret" -eq '0' ]; then
    msg "\\33[32m[✔]\\33[0m ${1}${2}"
  fi
}

error() {
  msg "\\33[31m[✘]\\33[0m ${1}${2}"
  exit 1
}

exists() {
  command -v "$1" >/dev/null 2>&1
}

sync_repo() {
  if [ ! -e "$repo_path" ]; then
    msg "\\033[1;34m==>\\033[0m Trying to clone $repo_name"
    mkdir -p "$repo_path"
    git clone -b "$repo_branch" "$repo_uri" "$repo_path" --depth=1
    ret="$?"
    success "Successfully cloned $repo_name."
  else
    msg "\\033[1;34m==>\\033[0m Trying to update $repo_name"
    cd "$repo_path" && git pull origin "$repo_branch"
    ret="$?"
    success "Successfully updated $repo_name"
  fi
  if [ ! -z "$_update" ]; then
    exit 0;
  fi
}

install_plugins() {
    for exe in "$@"; do
      eval "$exe +PlugInstall +qall"
    done
    ret="$?"
    success "Successfully installed plugins via vim-plug"
}

generate_dot_spacevim() {
  if [ ! -f "$HOME/.spacevim" ]; then
    cp "$HOME/.space-vim/init.spacevim" "$HOME/.spacevim"

    ret="$?"
    success "Successfully generated .spacevim in your home directory"
  fi
}

backup() {
  if [ -e "$1" ]; then
    echo
    msg "\\033[1;34m==>\\033[0m Attempting to back up your original vim configuration"
    today=$(date +%Y%m%d_%s)
    mv -v "$1" "$1.$today"

    ret="$?"
    success "Your original vim configuration has been backed up"
  fi
}

install_for_vim() {
  backup "$HOME/.vimrc"
  msg "\\033[1;34m==>\\033[0m Trying to download vim-plug"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  ret="$?"
  success "Successfully downloaded vim-plug"

  ln -sf "$HOME/.space-vim/init.vim" "$HOME/.vimrc"
  generate_dot_spacevim

  install_plugins "vim"
}

install_for_neovim() {
  backup "$HOME/.config/nvim/init.vim"
  msg "\\033[1;34m==>\\033[0m Trying to download vim-plug"
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  ret="$?"
  success "Successfully downloaded vim-plug"

  mkdir -p "$HOME/.config/nvim"
  ln -sf "$HOME/.space-vim/init.vim" "$HOME/.config/nvim/init.vim"
  generate_dot_spacevim

  install_plugins "nvim"
}

check_git() {
  if ! exists "git"; then
    error "You must have 'git' installed to continue"
  fi
}

infer() {
  if exists "vim" && exists "nvim"; then
    msg "\\033[1;34m==>\\033[0m Found both 'vim' and 'nvim' in your system"
    echo
    while true; do
      read -r -p "    Install space-vim for: [0]vim [1]nvim [2]vim and nvim: " opt
      case $opt in
        0)
          install_for_vim
          break
          ;;
        1)
          install_for_neovim
          break
          ;;
        2)
          install_for_vim
          install_for_neovim
          break
          ;;
        *)
          echo "Please answer 0, 1 or 2"
          ;;
      esac
    done
  elif exists "vim"; then
    msg "\\033[1;34m==>\\033[0m Only find 'vim' in your system"
    msg "    Starting to install space-vim for 'vim'"
    install_for_vim
  elif exists "nvim"; then
    msg "\\033[1;34m==>\\033[0m Only find 'nvim' in your system"
    msg "    Starting to install space-vim for 'nvim'"
    echo
    install_for_neovim
  else
    error "You must have 'vim' or 'nvim' installed to continue"
  fi
}

install() {
  if [ ! -z "$_all" ]; then
    install_for_vim
    install_for_neovim
    return
  fi
  if [ ! -z "$_vim" ]; then
    install_for_vim
  fi
  if [ ! -z "$_neovim" ]; then
    install_for_neovim
  fi
  infer
}

###############################
##  main
###############################
check_git

sync_repo

install

msg "\\nThanks for installing \\033[1;31m$app_name\\033[0m. Enjoy!"
