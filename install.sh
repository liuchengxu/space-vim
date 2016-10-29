#!/usr/bin/env bash

#   This setup file is based on spf13-vim's bootstrap.sh.
#   Thanks for spf13-vim.

app_name='space-vim'
[ -z "$APP_PATH" ] && APP_PATH="$HOME/.space-vim"
[ -z "$REPO_URI" ] && REPO_URI='https://github.com/liuchengxu/space-vim.git'
[ -z "$REPO_BRANCH" ] && REPO_BRANCH='vundle'
debug_mode='0'
[ -z "$VUNDLE_URI" ] && VUNDLE_URI="https://github.com/VundleVim/Vundle.vim"

########## Basic setup tools
msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
        msg "\33[32m[✔]\33[0m ${1}${2}"
    fi
}

error() {
    msg "\33[31m[✘]\33[0m ${1}${2}"
    exit 1
}

debug() {
    if [ "$debug_mode" -eq '1' ] && [ "$ret" -gt '1' ]; then
        msg "An error occurred in function \"${FUNCNAME[$i+1]}\" on line ${BASH_LINENO[$i+1]}, we're sorry for that."
    fi
}

program_exists() {
    local ret='0'
    command -v $1 >/dev/null 2>&1 || { local ret='1'; }

    # fail on non-zero return value
    if [ "$ret" -ne 0 ]; then
        return 1
    fi

    return 0
}

program_must_exist() {
    program_exists $1

    # throw error on non-zero return value
    if [ "$?" -ne 0 ]; then
        error "You must have '$1' installed to continue."
    fi
}

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
    ret="$?"
    debug
}

########## Setup function
do_backup() {
    if [ -e "$1" ] || [ -e "$2" ] || [ -e "$3" ]; then
        msg "Attempting to back up your original vim configuration."
        today=`date +%Y%m%d_%s`
        for i in "$1" "$2" "$3"; do
            [ -e "$i" ] && [ ! -L "$i" ] && mv -v "$i" "$i.$today";
        done
        ret="$?"
        success "Your original vim configuration has been backed up."
        debug
   fi
}

sync_repo() {
    local repo_path="$1"
    local repo_uri="$2"
    local repo_branch="$3"
    local repo_name="$4"

    if [ ! -e "$repo_path" ]; then
        msg "\033[1;34m==>\033[0m Trying to clone $repo_name"
        mkdir -p "$repo_path"
        git clone -b "$repo_branch" "$repo_uri" "$repo_path"
        ret="$?"
        success "Successfully cloned $repo_name."
    else
        msg "\033[1;34m==>\033[0m Trying to update $repo_name"
        cd "$repo_path" && git pull origin "$repo_branch"
        ret="$?"
        success "Successfully updated $repo_name"
    fi

    debug
}

create_symlinks() {
    local source_path="$1"
    local target_path="$2"

    lnif "$source_path/.vimrc"         "$target_path/.vimrc"
    lnif "$source_path/.vimrc.plug.list" "$target_path/.vimrc.plug.list"
    lnif "$source_path/.vimrc.plug.conf"  "$target_path/.vimrc.plug.conf"

    ret="$?"
    success "Setting up vim symlinks."
    debug
}

setup_vundle() {
    local system_shell="$SHELL"
    export SHELL='/bin/sh'

    vim \
        "+PluginInstall!" \
        "+PluginClean" \
        "+qall"

    export SHELL="$system_shell"

    success "Now updating/installing plugins using Vundle"
    debug
}


########## Main()
program_must_exist "vim"
program_must_exist "git"

do_backup       "$HOME/.vimrc" \
                "$HOME/.gvimrc"

sync_repo       "$APP_PATH" \
                "$REPO_URI" \
                "$REPO_BRANCH" \
                "$app_name"

create_symlinks "$APP_PATH" \
                "$HOME"

sync_repo       "$HOME/.vim/bundle/Vundle.vim" \
                "$VUNDLE_URI" \
                "master" \
                "vundle"

setup_vundle

msg             "\nThanks for installing \033[1;31m$app_name\033[0m."
msg             "\n⚠ Don't forget to compile YouCompleteMe and install necessary tools."
