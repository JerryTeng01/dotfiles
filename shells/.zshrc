DEFAULT_USER=jerryteng
export ZSH="/home/jerryteng/.oh-my-zsh"
ZSH_THEME="agnoster"
ENABLE_CORRECTION="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh

source /usr/bin/bash-wakatime/bash-wakatime.sh

alias mon2cam="deno run --unstable -A -r -q https://raw.githubusercontent.com/ShayBox/Mon2Cam/master/src/mod.ts"

[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.functions ] && source ~/.functions
