#!/bin/sh

echo "====== Setup Neovim ======"
# denite, deopleteが python3を必要とするので先にpythonのセッティングを行う
brew install pyenv
pyenv install 3.7.1
pyenv global 3.7.1
pip3 install pynvim # required https://github.com/roxma/nvim-yarp#requirements

brew install neovim
# deniteセットアップのためのシェルスクリプトをダウンロード & 実行
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
# For example, we just use `~/.cache/dein` as installation directory
sh ./installer.sh ~/.cache/dein

# set sym link
mkdir -p ~/.config/nvim
ln -snfv ${HOME}/dotfiles/.vimrc ${HOME}/.config/nvim/init.vim

# for incremental search by fzf
brew install ripgrep

# make rich vim icons
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font

# monaco powerline
wget https://gist.github.com/baopham/1838072/raw/2c0e00770826e651d1e355962e751325edb0f1ee/Monaco%20for%20Powerline.otf
mv Monaco\ for\ Powerline.otf /Library/Fonts/
echo "====== End ======"
