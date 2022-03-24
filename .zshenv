# Java
export JAVA_HOME=/usr/lib/jvm/java-11 

# Go
export GO_HOME=/usr/local/go
export GOPATH=$HOME/code/go

# pyenv
export PYENV="$HOME/.pyenv"

# tmux color
export TERM=xterm-256color

export EDITOR="vim"

export PATH=$PYENV/bin:$JAVA_HOME/bin:$GO_HOME/bin:$GOPATH/bin:~/.local/bin:$PATH
. "$HOME/.cargo/env"

eval "$(pyenv init --path)"
