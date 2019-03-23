# 日本語を使用
export LANG=ja_JP.UTF-8

# 補完
autoload -U compinit
compinit -u
zstyle ':completion:*:default' menu select=1        # 選択肢をハイライト
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 大文字、小文字を区別せず補完する
zstyle ':completion::complete:*' use-cache true     # キャッシュの利用による補完の高速化
# 補完候補を色付け
autoload -U colors
colors

# ビープ音の削除
setopt no_beep

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
PROMPT='%{$fg_bold[white]%}[  %{$fg_bold[blue]%}%T% %{$fg_bold[yellow]%} %n@%m% %{$fg_bold[white]%} %~% %{$reset_color%} ${vcs_info_msg_0_}%{$reset_color%} %{$fg_bold[white]%}]
%{${fg_bold[red]}%}%} $ % %{${reset_color}% '

#----------------------------------------------------------
# setting middleware
#----------------------------------------------------------
# ctrl + r でコマンド履歴一覧
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

# grepした上でそのファイルをvimで開く
function gv () {
  vim $(ag $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}
