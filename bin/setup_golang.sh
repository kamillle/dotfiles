#!/bin/sh

echo "====== Setup golang ======"
git clone https://github.com/syndbg/goenv.git ~/.goenv
# 最新版のgoをインストールする
LATEST_STABLE_GO=$(goenv install -l | grep -E "([1].[0-9].[0-9])|([1].[0-9][0-9].[0-9])" | tail -1)
goenv install $LATEST_STABLE_GO
goenv global $LATEST_STABLE_GO
echo "====== End ======"
