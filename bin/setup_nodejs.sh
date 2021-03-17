#!/bin/sh

echo "====== Setup nodejs ======"

brew install nodenv
brew install yarn
exec $SHELL -l
curl -fsSL https://github.com/nodenv/nodenv-installer/raw/master/bin/nodenv-doctor | bash

echo "====== End ======"

echo "====== Setup vue ======"
brew install yarn

yarn global add @vue/cli
yarn global add @vue/cli-init
echo "====== End ======="
