source ~/.zplug/init.zsh

# 日本語を使用
export LANG=ja_JP.UTF-8

# 補完
autoload -Uz compinit
compinit
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..

# ビープ音の削除
setopt no_beep

#----------------------------------------------------------
# prompt
#----------------------------------------------------------
# VCSの情報を取得するzsh関数
autoload -Uz vcs_info
autoload -Uz colors
colors

# PROMPT変数内で変数参照
setopt prompt_subst

zstyle ':vcs_info:git:*' check-for-changes true    #formats 設定項目で %c,%u が使用可
zstyle ':vcs_info:git:*' stagedstr "%F{red}C!"    #commit されていないファイルがある
zstyle ':vcs_info:git:*' unstagedstr "%F{blue}A+"  #add されていないファイルがある
zstyle ':vcs_info:*'     formats "%F{white}-> %c%u%b%f " #通常
zstyle ':vcs_info:*'     actionformats '(%b|%a)'       #rebase 途中,merge コンフリクト等 formats 外の表示

# %b ブランチ情報
# %a アクション名(mergeなど)
# %c changes
# %u uncommit

# プロンプト表示直前に vcs_info 呼び出し
precmd () { vcs_info }
PROMPT='%{$fg_bold[white]%}[  %{$fg_bold[blue]%}%T% %{$fg_bold[yellow]%} %n@%m% %{$fg_bold[white]%} %~% %{$reset_color%} ${vcs_info_msg_0_}%{$reset_color%} %{$fg_bold[white]%}]
%{${fg_bold[red]}%}%} %% %{${reset_color}% '

#----------------------------------------------------------
# setting middleware
#----------------------------------------------------------
# peco
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# search from terminal
g(){
    if [ $(echo $1 | egrep "^-[cfs]$") ]; then
        local opt="$1"
        shift
    fi
    local url="https://www.google.co.jp/search?q=${*// /+}"
    local app="/Applications"
    local g="${app}/Google Chrome.app"
    local s="${app}/Safari.app"
    case ${opt} in
        "-g")   open "${url}" -a "$g";;
        "-s")   open "${url}" -a "$s";;
        *)      open "${url}";;
    esac
  }

#----------------------------------------------------------
# PATH
#----------------------------------------------------------
# Ruby
eval "$(rbenv init -)"
#Python
PYENV_ROOT=~/.pyenv
export PATH=$PATH:$PYENV_ROOT/bin
eval "$(pyenv init -)"
# Go
export GOPATH=$HOME/go
export GOENV_ROOT=$HOME/.goenv
export PATH=bin:$GOENV_ROOT/bin:$GOPATH/bin:$PATH
eval "$(goenv init -)"
# elastic
export PATH="/usr/local/opt/elasticsearch@5.6/bin:$PATH"
# psql
export PGDATA="/usr/local/var/postgresql@9.6"
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"
# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="$HOME/.gem/ruby/2.0.0/bin:$PATH"
