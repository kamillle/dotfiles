#!/bin/sh

read -p "start dev setup? (y/N): " yn
case "$yn" in [yY]*) ;; *) echo "abort." ; exit ;; esac

# install homebrew
if (type brew > /dev/null 2>&1) ; then
  echo "======= Install Homebrew ======="
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "============= End =============="
fi

# install git
if brew list | grep git > /dev/null; then
  echo "======= Install git ======="
  brew install git
  echo "============= End =============="
fi

# dotfiles/.bashrc を読み込みbrew cask でのインストール先を /Applications に変更する
cp .bashrc ~/.bashrc
source ~/.bashrc

f [ -f ~/.bashrc ] ; then
  . ~/.bashrc
fi
