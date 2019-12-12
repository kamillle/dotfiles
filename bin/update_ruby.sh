#!/bin/sh

if !(type brew > /dev/null 2>&1); then
  echo "Error: Require Homebrew"
  exit
fi

# available_versions=$(rbenv install -l | grep -v - | grep "[2-3].[0-9].[0-9]")
#
# echo "=========versions list ========= \n"
# echo "$available_versions \n"

read -p "which version do you want?: " version

case "$version" in
  # 正常系
  [1-3].[0-9].[0-9]*)

    echo "Updating rbenv ruby-build..."
    brew update
    brew upgrade rbenv ruby-build

    message="\nInstalling ${version}..."
    echo ${message}
    rbenv install $version

    # setup needed gems
    rbenv rehash
    rbenv shell $version
    gem install bundler
    # for neovim
    gem install nvim
    gem install nvim
    # for LSP
    gem install solargraph
    ;;

  # 異常系
  *)
    echo "the version is invalid" ; exit
    ;;
esac
