#!/bin/sh

read -p "start dev setup? (y/N): " yn
case "$yn" in
  [yY]*)
    ;;
  *)
    echo "abort." ; exit
    ;;
esac

if ! command -v brew &> /dev/null;then
  echo "======= Install Homebrew ======="

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ${HOME}/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"

  echo "======= End ======"
fi

# install git
if brew list | grep git > /dev/null; then
  echo "====== Install git ======="

  brew install git

  echo "====== End ======"
fi

echo "====== Setup git ======"

ln -snfv ${HOME}/dotfiles/config/gitconfig ${HOME}/.gitconfig
ln -snfv ${HOME}/dotfiles/config/gitignore_global ${HOME}/.gitignore_global

echo "======= End ======"


echo "====== Install Applications ======"

brew install mas # App StoreのアプリをCLIでダウンロードできるようにする
# Xcode
mas install 497799835
# Kindle
mas install 405399194
# Skitch
mas install 425955336
# LINE
mas install 539883307
# BetterSnapTool
mas install 417375580
# Meeter
mas install 1510445899
# Spark mail
mas install 1176895641

brew install MonitorControl

# brew cask でのinstallでは ~/Applications にインストールを行ってしまうため
# /Applications にインストールするようにPATHを変更する
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

brew install --cask google-chrome
brew install --cask google-japanese-ime
brew install --cask visual-studio-code
brew install --cask zoom
brew install --cask discord
brew install --cask keyboardcleantool
brew install --cask slack
brew install --cask cmd-eikana
brew install --cask alfred
brew install --cask appcleaner
brew install --cask clipy
brew install --cask dash
brew install --cask iterm2
brew install --cask karabiner-elements
brew install --cask skitch
brew install --cask postman
brew install --cask notion
brew install --cask spotify
brew install --cask 1password
brew install --cask microsoft-edge
brew install --cask alt-tab
# mysql GUI for mojave
brew install --cask homebrew/cask-versions/sequel-pro-nightly
# dockerは brew, brew cask 両方必要
brew install docker --cask
brew install docker
brew install awscli
brew install --cask google-cloud-sdk
echo "====== End ======"


echo "====== Setup zsh ======"
brew install zsh
brew install zsh-completions
brew install zplug

sudo sh -c "echo /opt/homebrew/bin/zsh >> /etc/shells"
# change login shell
chsh -s /opt/homebrew/bin/zsh

ln -snfv ${HOME}/dotfiles/config/zshrc ${HOME}/.zshrc

source ${HOME}/.zshrc
echo "====== End ======"

echo "====== Setup tmux ======"
brew install tmux
brew install reattach-to-user-namespace

ln -snfv ${HOME}/dotfiles/config/tmux.conf ${HOME}/.tmux.conf

tmux source ${HOME}/.tmux.conf
echo "====== End ======"

echo "====== Setup karabiner ======"
mkdir ${HOME}/.config
ln -snfv ${HOME}/dotfiles/karabiner ${HOME}/.config/karabiner
echo "====== End ======"

echo "====== Setup CLI ======"
brew install htop
brew install tig
brew install trash
brew install tree
brew install gnu-sed
brew install the_silver_searcher
brew install github/gh/gh
brew install jid
brew install peco
mkdir -p ${HOME}/.config/peco
ln -snfv ${HOME}/dotfiles/config/peco.json ${HOME}/.config/peco/config.json
mkdir -p ${HOME}/.bundle
ln -snfv ${HOME}/dotfiles/config/bundler ${HOME}/.bundle/config
echo "====== End ======"

echo "====== Setup ghq ======"
brew install ghq
# ghq default root path
mkdir ${HOME}/ghq
echo "====== End ======"

echo "====== Setup vim ======"
ln -snfv ${HOME}/dotfiles/config/vimrc ${HOME}/.vimrc
ln -snfv ${HOME}/dotfiles/config/ideavimrc ${HOME}/.ideavimrc
echo "====== End ======"

echo "====== Setup asdf ======"
brew install asdf
ln -snfv ${HOME}/dotfiles/config/asdfrc ${HOME}/.asdfrc
ln -snfv ${HOME}/dotfiles/config/default-python-packages ${HOME}/.default-python-packages
ln -snfv ${HOME}/dotfiles/config/default-npm-packages ${HOME}/.default-npm-packages
echo "====== End ======"

# echo "======= Setup xxx ======="
# echo "======= End ======"
