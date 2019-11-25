#!/bin/sh

read -p "start dev setup? (y/N): " yn
case "$yn" in
  [yY]*)
    ;;
  *)
    echo "abort." ; exit
    ;;
esac

echo "======= Update apt ======="

sudo apt update
sudp apt upgrade

echo "====== Update apt ======"

# install git
if sudo apt list --installed git | grep Done > /dev/null; then
  echo "======= Install git ======="

  sudo apt install git

  echo "========== End ============"
fi

echo "======= Setup git ======="

ln -snfv ${HOME}/dotfiles/git_setting/gitconfig ${HOME}/.gitconfig
ln -snfv ${HOME}/dotfiles/git_setting/gitignore_global ${HOME}/.gitignore_global

echo "===== End ====="


echo "===== pbcopy behavior ====="
if sudo apt list --installed git | grep Done > /dev/null; then
  sudo apt-get install xsel
fi
echo "===== End ====="

echo "======= Install Applications ======="

# brew install mas # App StoreのアプリをCLIでダウンロードできるようにする
# mas install 497799835  # Xcode
# mas install 405399194  # Kindle
# mas install 425955336  # Skitch
# mas install 485812721  # TweetDeck
# mas install 1295203466 # Microsoft Remote Desktop (10.2.13)
# mas install 539883307  # LINE
# mas install 417375580  # BetterSnapTool
#
# brew cask install homebrew/cask-versions/sequel-pro-nightly # mysql GUI for mojave
# brew cask install clipy       # extend pdcopy
# brew cask install dash        # リファレンス見る
# brew cask install karabiner   # customize key mapping
# # dockerは brew, brew cask 両方必要
# brew install docker
# brew cask install docker

# ブラウザからダウンロード
# chrome, slack, typora, dropbox

# ランチャー
# albert
# @see https://github.com/albertlauncher/albert

echo "============= End =============="


echo "======= Setup zsh ======="

# brew install zsh
# brew install zsh-completions
#
# sudo sh -c "echo /usr/local/bin/zsh >> /etc/shells"
# # change login shell
# chsh -s /usr/local/bin/zsh
#
ln -snfv ${HOME}/dotfiles/ubuntu/.zshrc ${HOME}/.zshrc
#
source ${HOME}/.zshrc

echo "================ End ================"

echo "======= Setup tmux ======="

if sudo apt list --installed tmux | grep Done > /dev/null; then
  sudo apt install tmux
fi

ln -snfv ${HOME}/dotfiles/ubuntu/.tmux.conf ${HOME}/.tmux.conf

tmux source ${HOME}/.tmux.conf

echo "================ End ================"

echo "======= Setup CLI ======="

# brew install trash

sudo apt install peco
sudo apt install htop
sudo apt install tree
sudo apt install silversearcher-ag
# for mysql2 gem
sudo apt install libmysqld-dev

echo "========== End =========="

echo "======= Setup Neovim ======="

# needed pyenv
# @see https://github.com/pyenv/pyenv

sudo apt install neovim

# set sym link
ln -snfv ${HOME}/dotfiles/ubuntu/.vimrc ${HOME}/.config/nvim/init.vim

# for incremental search by fzf
# @see https://github.com/BurntSushi/ripgrep

# make rich vim icons
# brew cask install font-hack-nerd-font

# monaco powerline
# wget https://gist.github.com/baopham/1838072/raw/2c0e00770826e651d1e355962e751325edb0f1ee/Monaco%20for%20Powerline.otf
# mv Monaco\ for\ Powerline.otf /Library/Fonts/

### 以下は実行しなくてもdein動いた ###
# deniteセットアップのためのシェルスクリプトをダウンロード & 実行
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
# For example, we just use `~/.cache/dein` as installation directory
sh ./installer.sh ~/.cache/dein

echo "============ End ============="


echo "======= Setup Ruby ======="

# Install rbenv and ruby-build
# @see https://github.com/rbenv/ruby-build/wiki#suggested-build-environment

# Install readline
# Using Ubuntu, install libreadline-dev instead of readline
sudo apt install libreadline-dev

# neovimが ruby2.6.2 と neovim gem を参照するので入れておく
# 2.6.2 が古くなったらvimrcに書いてあるneovimが参照するバージョンを変更すること
rbenv install 2.6.5
rbenv global 2.6.5
gem install neovim

# 最新版をインストールする
LATEST_STABLE_RUBY = $(rbenv install -l | grep -v - | tail -1)
rbenv install LATEST_STABLE_RUBY
rbenv global LATEST_STABLE_RUBY
gem install bundler
rbenv rehash

ln -snfv ${HOME}/dotfiles/.pryrc ${HOME}/.pryrc

echo "========== End ==========="


echo "======= Setup golang ======="

# @see https://github.com/syndbg/goenv/blob/master/INSTALL.md

echo "========== End ==========="

echo "======= Setup nvm ======="

mkdir ${HOME}/.nvm
sudo apt install nvm

nvm install v10.13.0
node -v
nvm use 10.13.0

# make available git open command
npm install --global git-open

echo "========== End ==========="
