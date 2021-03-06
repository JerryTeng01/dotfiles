export JAVA_HOME=/usr/lib/jvm/java-11
export MAVEN_INSTALL=/opt/maven
export DENO_INSTALL=$HOME/.deno
export GO_HOME=/usr/local/go
export GOPATH=~/code/go
export PIN_ROOT=/opt/pin
export PIN_HOME=/opt/pin
export PATH=$PATH:$JAVA_HOME/bin:$MAVEN_INSTALL/bin:$DENO_INSTALL/bin:$GO_HOME/bin:$GOPATH/bin:$PIN_ROOT:$PIN_HOME

if [ -d "$HOME/bin" ]; then
    export PATH="$HOME/bin:$PATH"
fi

export EDITOR="vim"
export TERMINAL="alacritty"
export WM="qtile"
