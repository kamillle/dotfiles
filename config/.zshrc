typeset -U path PATH
path=(
  /opt/homebrew/bin(N-/)
  /opt/homebrew/sbin(N-/)
  /usr/bin
  /usr/sbin
  /bin
  /sbin
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /Library/Apple/usr/bin
)

export LANG=ja_JP.UTF-8 # 日本語を使用
setopt no_beep
# use vi mode
# bindkey -v
bindkey -e

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
precmd () {
  vcs_info
  # git config から remote.origin.url を取得
  if git rev-parse --git-dir > /dev/null 2>&1; then
    REPO_URL=$(git config --get remote.origin.url)
    # ssh://git@ で始まる場合は https:// に置換
    if [[ $REPO_URL =~ ^ssh://git@ ]]; then
      REPO_URL=$(echo $REPO_URL | sed 's|^ssh://git@|https://|')
    fi
    if [[ $REPO_URL =~ ^git@ ]]; then
      REPO_URL=$(echo $REPO_URL | sed 's|^git@|https://|')
    fi
    if [[ $REPO_URL =~ ^https://github.com: ]]; then
      REPO_URL=$(echo $REPO_URL | sed 's|^https://github.com:|https://github.com/|')
    fi

    # .git で終わる場合は削除
    REPO_URL=${REPO_URL%.git}
  else
    REPO_URL=""
  fi

  # hostnameに応じてemojiを設定
  if [[ $(hostname) == "Yujis-MBA-M2.local" ]]; then
    EMOJI="💻"
  else
    EMOJI="❓"
  fi
}
PROMPT='${EMOJI} %{$fg_bold[yellow]%}%~%{$reset_color%} ${vcs_info_msg_0_}${REPO_URL:+| $REPO_URL}
%{${fg_bold[red]}%}%}  $ % %{${reset_color}%}'

#----------------------------------------------------------
# alias
#----------------------------------------------------------

alias be="bundle exec"
alias agg="ag -g"
alias ac="git add . && git commit"
alias c="claude"
alias cl="claer"
alias rm="trash"
alias ls="ls -G"
alias tf="terraform"
alias py="python"
alias ct='cd "$(git rev-parse --show-toplevel)"'
alias n='npm'
alias repo='gh repo view -w'

# For kubernetes
# [[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
# alias k="kubectl"

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
. /opt/homebrew/opt/asdf/libexec/asdf.sh

export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh
export PATH="/opt/homebrew/bin":$PATH

export VISUAL='vim'

# brew cask でのinstallでは ~/Applications にインストールを行ってしまうため
# /Applications にインストールするようにPATHを変更する
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# kubectl krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export HOMEBREW_NO_AUTO_UPDATE=1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#----------------------------------------------------------
# functions
#----------------------------------------------------------
# ctrl + r でコマンド履歴一覧
function fzf-history-selection() {
    BUFFER=$(history -n 1 | tail -r | awk '!a[$0]++' | fzf --height 60% --reverse)
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N fzf-history-selection
bindkey '^R' fzf-history-selection

# ctrl + ] でghq
function ghq-fzf() {
  local src=$(ghq list | fzf --reverse --height 95% --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^]' ghq-fzf

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# bun completions
[ -s "/Users/yuji/.bun/_bun" ] && source "/Users/yuji/.bun/_bun"
export PATH="$HOME/.local/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/yuji/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
