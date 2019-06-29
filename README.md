# How to setup

```
cd ~
git clone git@github.com:kamillle/dotfiles.git
cd dotfiles
chmod 777 ./bin/dev_setup.sh
./bin/dev_setup.sh
```

適当に作ったからシェルスクリプト動かないかも〜
大枠は作ったので次PC返る時頑張ろう

# my todo list
## set node.js provider for neovim
should install neovim for node.js via npm and set `let g:node_host_prog=PATH`
run `nvm which neovim-node-host` to detect PATH
