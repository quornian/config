#!/bin/bash

function main() {
    install bash ~/.bash
    install bash_profile ~/.bash_profile
    install bashrc ~/.bashrc
    install bin ~/bin
    install gdb ~/.gdb
    install gdbinit ~/.gdbinit
    install gitconfig ~/.gitconfig
    install gitk ~/.gitk
    install inputrc ~/.inputrc
    install screenrc ~/.screenrc
    install tmux.conf ~/.tmux.conf
    install vim ~/.vim
    install vimrc ~/.vimrc
    install Xresources ~/.Xresources
    install Xresources.d ~/.Xresources.d

    git submodule update --init --recursive
    [ -e vim/bundle/YouCompleteMe/python/ycm_core.so ] || \
        ( cd vim/bundle/YouCompleteMe && ./install.sh; )
}

function install() {
    source="$1"
    target="$2"
    while [ -e "$target" ]
    do
        if [ "$(readlink -m "$target")" = "$(readlink -m "$source")" ]
        then
            echo "Already installed '$target'."
            return
        elif same "$target" "$source"
        then
            echo "Installed file is identical but isn't linked the same way."
            echo "Are we okay to replace '$target' [y|N]?"
            read -p "> " choice
            case $choice in
                y|Y) rm -i "$target"; continue; ;;
            esac
        fi
        echo "What should be done with the existing '${target}'?"
        echo "  [S]kip"
        echo "  [B]ackup first, then install"
        echo "  [D]elete then install"
        echo "  [V]iew differences (existing, new)"
        read -p "> " choice
        case $choice in
            s|S) return; ;;
            b|B) backup "$target"; ;;
            d|D) rm -i "$target"; ;;
            v|V) vim -d "$target" "$source"; ;;
        esac
    done
    echo "Installing '$source' to '$target'..."
    ln -sv "$(readlink -m "$source")" "$target"
}

function backup() {
    echo "Backing up '$1'..."
    mkdir backup 2>/dev/null || test -d backup
    if [ -e "backup/$1" ]
    then
        echo "Backup already exists: backup/$1"
        return
    fi
    mv -v "$1" "backup/$1"
}

function same() {
    diff "$1" "$2" > /dev/null
}

main

