export LANG=ja_JP.UTF-8 # 日本語を使用
setopt no_beep
# use vi mode
# bindkey -v

#----------------------------------------------------------
# completion
#----------------------------------------------------------
autoload -U compinit
compinit -u
zstyle ':completion:*:default' menu select=1        # 選択肢をハイライト
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 大文字、小文字を区別せず補完する
zstyle ':completion::complete:*' use-cache true     # キャッシュの利用による補完の高速化
# 補完候補を色付け
autoload -U colors
colors

#----------------------------------------------------------
# prompt
#----------------------------------------------------------
# VCSの情報を取得するzsh関数
autoload -Uz vcs_info

# PROMPT変数内で変数参照
setopt prompt_subst

# %b ブランチ情報
# %a アクション名(mergeなど)
# %c changes
# %u uncommit

zstyle ':vcs_info:git:*' check-for-changes true          # formats 設定項目で %c,%u が使用する true にすると重い...
zstyle ':vcs_info:git:*' unstagedstr "%F{blue}A+"        # add されていないファイルがある
zstyle ':vcs_info:git:*' stagedstr "%F{red}C!"           # commit されていないファイルがある
zstyle ':vcs_info:*'     formats "%F{white}-> %c%u%b%f " # 通常
zstyle ':vcs_info:*'     actionformats '(%b|%a)'         # rebase 途中,merge コンフリクト等 formats 外の表示

# プロンプト表示直前に vcs_info 呼び出し
precmd () { vcs_info }
PROMPT='%{$fg_bold[yellow]%} %~% %{$reset_color%} ${vcs_info_msg_0_}%{$reset_color%}
%{${fg_bold[red]}%}%}  $ % %{${reset_color}%'

#----------------------------------------------------------
# alias
#----------------------------------------------------------
# alias py="python"
# alias ipy="ipython"
# alias es="elasticsearch"
# alias be="bundle exec"
# alias ber="bundle exec rubocop"
# alias sr="bundle exec spring rspec"
# alias rm="trash"
# alias agg="ag -g"
# alias ls="ls -G"
# alias ctags="`brew --prefix`/bin/ctags"
alias v="nvim"
alias vim="nvim"
alias vi="nvim"
alias ac="git add . && git cm"
alias c="clear"
alias pbcopy='xsel --clipboard --input' # @see https://qiita.com/yoshikyoto/items/1676b925580717c0a443

#----------------------------------------------------------
# command history
#----------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000
# ignore duplication command history list
setopt hist_ignore_dups
# share command history data
setopt share_history

#----------------------------------------------------------
# environment variable
#----------------------------------------------------------
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh
export PATH="/usr/local/bin":$PATH

# Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Python
export PYENV_ROOT="${HOME}/.pyenv"
export PATH=${PYENV_ROOT}/bin:$PATH
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# Go
export GOPATH=$HOME/go
export GOENV_ROOT=$HOME/.goenv
export GO_WORKSPACE=$HOME/go/src/github.com/kamillle
export PATH="$GOENV_ROOT/bin:$PATH"
export PATH="$GOROOT/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
eval "$(goenv init -)"

# elastic
#export PATH="/usr/local/opt/elasticsearch@5.6/bin:$PATH"

# psql
export PGDATA="/usr/local/var/postgresql@9.6"
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"

export PATH="$HOME/.gem/ruby/2.0.0/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# java
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"

# chromedriver
export CHROMEDRIVER_PATH='/usr/local/bin/chromedriver'

# neovim
export XDG_CONFIG_HOME="$HOME/.config"

# direnv
eval "$(direnv hook zsh)"

export PATH="/usr/local/opt/openssl/bin:$PATH"

# yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pecoを優先するためコメントアウト
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#----------------------------------------------------------
# define functions
#----------------------------------------------------------
# ctrl + r でコマンド履歴一覧
function peco-history-selection() {
    # tailの-rオプションはmacにしかないためtacを使う
    BUFFER=`history -n 1 | tac | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

# grepした上でそのファイルをvimで開く
function gg () {
  vim $(ag $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

# 遅いのでコメントアウトしてる
# hubコマンドをgitコマンドとして使用
# see: https://qiita.com/yaotti/items/a4a7f3f9a38d7d3415e3
# function git(){hub "$@"}

# snakecase への変換
function snake() {
  echo $1 | gsed -r -e 's/^([A-Z])/\L\1\E/' -e 's/([A-Z])/_\L\1\E/g' | pbcopy
}

# upper camel への変換
function camel() {
  echo $1 | gsed -r -e 's/(^|_)(.)/\U\2\E/g' | pbcopy
}

# springで起動しているrails appを全部殺すマン
function kspring() {
  pkill spring
}
