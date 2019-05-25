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

echo "======= Install Applications ======="

brew install mas # App StoreのアプリをCLIでダウンロードできるようにする
mas install 497799835  # Xcode
mas install 405399194  # Kindle
mas install 715768417  # Microsoft Remote Desktop (8.0.30030)
mas install 425955336  # Skitch
mas install 485812721  # TweetDeck
mas install 1295203466 # Microsoft Remote Desktop (10.2.13)
mas install 539883307  # LINE
mas install 417375580  # BetterSnapTool

brew cask install google-chrome
brew cask install google-chrome-canary
brew cask install google-japanese-ime
brew cask install firefox
brew cask install sequel-pro  # mysql GUI
brew cask install slack       # slackたん
brew cask install typora      # md editor
brew cask install cmd-eikana  # 英かな使えるかわからん
brew cask install alfred      # lancher
brew cask install hyperswitch # cmd + tab でwindow毎に切り替え
brew cask install appcleaner  # remove applications
brew cask install dropbox     # share files
brew cask install clipy       # extend pdcopy
brew cask install dash        # リファレンス見る
brew cask install iterm2      # CLI
brew cask install karabiner   # customize key mapping
brew cask install evernote    # memo
brew cask install skitch      # edit images
# dockerは brew, brew cask 両方必要
brew install docker
brew cask install docker

echo "============= End =============="
