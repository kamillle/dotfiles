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
