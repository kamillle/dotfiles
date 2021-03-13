#!/bin/sh

echo "====== Setup nodejs ======"
brew install nvm
mkdir ${HOME}/.nvm

nvm install v10.13.0
node -v
nvm use 10.13.0

brew install nodenv
curl -fsSL https://github.com/nodenv/nodenv-installer/raw/master/bin/nodenv-doctor | bash

# make available git open command
npm install --global git-open
echo "====== End ======"

echo "====== Setup vue ======"
brew install yarn

yarn global add @vue/cli
yarn global add @vue/cli-init
echo "====== End ======="
