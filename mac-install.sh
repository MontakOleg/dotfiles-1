#!/usr/bin/env bash
# This is an ugly script for bootstrapping OS X setup

if ! which xcodebuild &> /dev/null; then
    echo "You need to install the Xcode Command Line Tools before running this script"
    exit
fi

ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)" &
wait

if [[ ! -e "manage.sh" ]]; then
    echo "Make sure you have the manage script in the same directory!"
    exit
fi

./manage.sh install &
rm -rf $HOME/.rbenv
wait
./osx.txt &
wait

if [[ ! -e "$HOME/.bashrc" ]]; then
    echo "Looks like the manage script failed, try and run it manually"
    exit
fi

source "$HOME/.bashrc"

if ! which brew &> /dev/null; then
    echo "Homebrew is not installed in your \$PATH"
    exit
fi

brew install ack appledoc automake bash bash-completion curl git heroku-toolbelt hub imagemagick llvm lynx macvim make markdown mercurial mogenerator mysql node openssh openssl postgresql rsync tree vim wget zsh zsh-completions

git clone git://github.com/sstephenson/rbenv.git $HOME/.rbenv
git clone https://github.com/sstephenson/rbenv-default-gems.git $HOME/.rbenv/plugins/rbenv-default-gems
git clone git://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
git clone https://github.com/sstephenson/rbenv-gem-rehash.git $HOME/.rbenv/plugins/rbenv-gem-rehash
git clone git://github.com/tpope/rbenv-readline.git $HOME/.rbenv/plugins/rbenv-readline

./manage.sh install &
wait

brew link openssl --force
rbenv install 1.9.3-p385 2.0.0-p195
brew unlink openssl

