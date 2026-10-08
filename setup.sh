#!/bin/bash
# Assume cloned into ~/git/dotfiles
DOTFILES=~/git/dotfiles

link() {
  local src="$DOTFILES/$1"
  local dest="$HOME/$2"
  if [ -f "$src" ]; then
    ln -sf "$src" "$dest"
  else
    echo "Skipping missing file: $src" >&2
  fi
}

link .aliases .aliases
link .bash_profile .bash_profile
link .zshrc .zshrc
link .zprofile .zprofile
link .zlogin .zlogin
link .gitconfig .gitconfig
link .gitignore.global .gitignore.global
link .tmux.conf .tmux.conf
