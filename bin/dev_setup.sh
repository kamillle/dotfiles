#!/bin/sh

read -p "start dev setup? (y/N): " yn
case "$yn" in [yY]*) ;; *) echo "abort." ; exit ;; esac

# install homebrew
if (type brew > /dev/null 2>&1) ; then
  echo "======= Install Homebrew ======="
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew -v
  echo "============= End =============="
fi

# install git
if brew list | grep git > /dev/null; then
  echo "======= Install git ======="
  brew install git
  echo "============= End =============="
fi
