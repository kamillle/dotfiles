#!/bin/sh

if (type brew > /dev/null 2>&1) ; then
  # brewがない場合はインストールできないよう
  exit
fi

echo "======= Install Neovim ======="
brew install neovim
echo "============ End ============="

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
# For example, we just use `~/.cache/dein` as installation directory
sh ./installer.sh ~/.cache/dein

# set sym link
ln -snfv ${HOME}/dotfiles/.vimrc ${HOME}/.config/nvim/init.vim

# for fzf
brew install ripgrep

# make rich vim icons
brew cask install font-hack-nerd-font
