#!/bin/sh

echo "====== Setup Ruby ======"
brew install rbenv ruby-build

brew install readline
brew link readline --force
RUBY_CONFIGURE_OPTS="--with-readline-dir=$(brew --prefix readline)"
echo 'export PATH="$HOME/.rbenv/bin/:$PATH" >> ~/.zshrc'
echo 'eval "$(rbenv init -)" >> ~/.zshrc'

# 最新版をインストールする
LATEST_STABLE_RUBY=$(rbenv install -l | grep -v - | tail -1)
rbenv install $LATEST_STABLE_RUBY
rbenv global $LATEST_STABLE_RUBY
rbenv rehash

ln -snfv ${HOME}/dotfiles/.pryrc ${HOME}/.pryrc
echo "====== End ======"
