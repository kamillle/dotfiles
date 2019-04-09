# neovimの設定ファイルにシンボリックリンクを貼る
`ln -snfv ${HOME}/dotfiles/.vimrc ${HOME}/.config/nvim/init.vim`

# :R での検索に使用するモジュール
brew install ripgrep

# airlineで文字化けする場合は下記をinstallし
# iterm2で、Preferences → Profiles → Text → Non-ANCII Font を xxx pownerline というものにする
https://github.com/powerline/fonts

## vim内のicon表示をリッチにする
brew tap caskroom/fonts
brew cask install font-hack-nerd-font
`iterm2で、Preferences → Profiles → Text → Non-ANCII Font を Hack Regular Nerd Font Complate というものにする`

# vim 内でgit commandを使う
cd ~/.vim/bundle
git clone https://github.com/tpope/vim-fugitive.git
vim -u NONE -c "helptags vim-fugitive/doc" -c q
