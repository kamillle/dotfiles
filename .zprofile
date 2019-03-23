# コマンド履歴
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# ignore duplication command history list
setopt hist_ignore_dups
# share command history data
setopt share_history

# alias
alias py="python"
alias ipy="ipython"
alias es="elasticsearch"
alias be="bundle exec"
alias ber="bundle exec rubocop"
alias sr="bundle exec spring rspec"
alias rm="trash"
alias agg="ag -g"
alias ls="ls -G"
alias ctags="`brew --prefix`/bin/ctags"
alias v="nvim"
alias vim="nvim"
alias vi="nvim"

#----------------------------------------------------------
# PATH
#----------------------------------------------------------
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh
export PATH="/usr/local/bin":$PATH
# Ruby
eval "$(rbenv init -)"
# Python
export PYENV_ROOT="${HOME}/.pyenv"
export PATH=${PYENV_ROOT}/bin:$PATH
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
# Go
export GOPATH=$HOME/go
export GOENV_ROOT=$HOME/.goenv
export PATH=bin:$GOENV_ROOT/bin:$GOPATH/bin:$PATH
eval "$(goenv init -)"
# elastic
#export PATH="/usr/local/opt/elasticsearch@5.6/bin:$PATH"
# psql
export PGDATA="/usr/local/var/postgresql@9.6"
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"
# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="$HOME/.gem/ruby/2.0.0/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
# java
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"

eval "$(direnv hook zsh)"
export PATH="/usr/local/opt/openssl/bin:$PATH"

# chromedriver
export CHROMEDRIVER_PATH='/usr/local/bin/chromedriver'
