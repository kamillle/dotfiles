#!/bin/sh

echo "====== Setup Ruby ======"
brew install rbenv ruby-build

brew install readline
brew link readline --force
RUBY_CONFIGURE_OPTS="--with-readline-dir=$(brew --prefix readline)"

# 最新版をインストールする
LATEST_STABLE_RUBY=$(rbenv install -l | grep -v - | tail -1)
rbenv install $LATEST_STABLE_RUBY
rbenv global $LATEST_STABLE_RUBY
rbenv rehash

mkdir ${HOME}/.bundle
ln -snfv ${HOME}/dotfiles/bundle_config ${HOME}/.bundle/config
ln -snfv ${HOME}/dotfiles/.pryrc ${HOME}/.pryrc
echo "====== End ======"
