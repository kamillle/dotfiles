# コマンド履歴
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

# コマンド履歴検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# alias
alias diff="coloddiff"

##### PATH #####
# Ruby
eval "$(rbenv init -)"
#Python
PYENV_ROOT=~/.pyenv
export PATH=$PATH:$PYENV_ROOT/bin
eval "$(pyenv init -)"
# elastic
export PATH="/usr/local/opt/elasticsearch@5.6/bin:$PATH"
# psql
export PGDATA=/usr/local/var/postgres
# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
# connect development server
export CONNECT_BASIC_AUTH_USERNAME= "cotree"
export CONNECT_BASIC_AUTH_PASSWORD= "toceer1"

