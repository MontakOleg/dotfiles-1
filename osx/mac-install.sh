#!/usr/bin/env bash
# This is a script for bootstrapping macOS setup

set -euo pipefail

if [[ ! -e ./manage.sh ]]; then
  echo "This script must be run from the root of the dotfiles repo"
  exit 1
fi

./manage.sh install

if [[ ! -e "$HOME/.bashrc" ]]; then
  echo "Looks like the manage script failed, try and run it manually"
  exit 1
fi

if ! command -v brew &> /dev/null; then
  echo "You need to install homebrew"
  exit 1
fi

# Set correct netrc permissions
touch "$HOME/.netrc"
chmod 0600 "$HOME/.netrc"

# Correct gnupg permissions after linking, this must be done before a private
# key is added otherwise it will bork the key setup
# https://superuser.com/a/954536
chown -R "$(whoami)" ~/.gnupg/
chmod 600 ~/.gnupg/*
chmod 700 ~/.gnupg

# Add Terminal.app theme
open ./osx/parsec.terminal

# Install some default software
brew bundle --file="./osx/Brewfile"
brew bundle --file="./osx/Brewfile.cask"

# Set many default settings
./osx/defaults.sh
