#!/bin/sh

read -p "start dev setup? (y/N): " yn
case "$yn" in
  [yY]*)
    ;;
  *)
    echo "abort." ; exit
    ;;
esac

# install homebrew
if (type brew > /dev/null 2>&1) ; then
  echo "======= Install Homebrew ======="

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  echo "======= End ======"
fi

# install git
if brew list | grep git > /dev/null; then
  echo "====== Install git ======="

  brew install git

  echo "====== End ======"
fi

echo "====== Setup git ======"

ln -snfv ${HOME}/dotfiles/git_setting/gitconfig ${HOME}/.gitconfig
ln -snfv ${HOME}/dotfiles/git_setting/gitignore_global ${HOME}/.gitignore_global

echo "======= End ======"


echo "====== Install Applications ======"

brew install mas # App StoreのアプリをCLIでダウンロードできるようにする
# Xcode
mas install 497799835
# Kindle
mas install 405399194
# Skitch
mas install 425955336
# TweetDeck
mas install 485812721
# LINE
mas install 539883307
# BetterSnapTool
mas install 417375580
# RunCat
mas install 1429033973

# TODO: /Applications 配下にあるならインストールしない、ないならインストールするみたいにしたい
# dotfiles/.bashrc を読み込みbrew cask でのインストール先を /Applications に変更する
cp .bashrc ~/.bashrc
source ~/.bashrc

# f [ -f ~/.bashrc ] ; then
#   . ~/.bashrc
# fi

brew install google-chrome --cask
brew install google-chrome-canary --cask
brew install google-japanese-ime --cask
brew install visual-studio-code --cask
brew install skype --cask
brew install zoom --cask
brew install homebrew/cask-versions/sequel-pro-nightly --cask # mysql GUI for mojave
brew install keyboardcleantool --cask # disable keyboard when clean up it
brew install slack --cask
brew install typora --cask
brew install cmd-eikana --cask
brew install alfred --cask
brew install hyperswitch --cask
brew install appcleaner --cask
brew install clipy --cask       # extend pdcopy
brew install dash --cask        # watch docs
brew install iterm2 --cask
brew install karabiner --cask   # customize key mapping
brew install skitch --cask      # edit images
brew install postman --cask
brew install notion --cask
# dockerは brew, brew cask 両方必要
brew install docker
brew install docker --cask

echo "====== End ======"


echo "====== Setup zsh ======"

brew install zsh
brew install zsh-completions
brew install zplug

sudo sh -c "echo /usr/local/bin/zsh >> /etc/shells"
# change login shell
chsh -s /usr/local/bin/zsh

ln -snfv ${HOME}/dotfiles/.zshrc ${HOME}/.zshrc

source ${HOME}/.zshrc

echo "====== End ======"

echo "====== Setup tmux ======"

brew install tmux
brew install reattach-to-user-namespace

ln -snfv ${HOME}/dotfiles/.tmux.conf ${HOME}/.tmux.conf

tmux source ${HOME}/.tmux.conf

echo "====== End ======"

echo "====== Setup karabiner ======"

ln -snfv ${HOME}/dotfiles/karabiner ${HOME}/.config/karabiner

echo "====== End ======"

echo "====== Setup CLI ======"

brew install peco
brew install htop
brew install tig
brew install trash
brew install tree
brew install gnu-sed
brew install the_silver_searcher
brew install github/gh/gh
brew install jid

echo "====== End ======"

echo "====== Setup ghq ======"
brew install ghq
# ghq default root path
mkdir ~/ghq
echo "====== End ======"

# echo "======= Setup xxx ======="
# echo "======= End ======"
