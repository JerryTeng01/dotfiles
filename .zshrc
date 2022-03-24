export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(
    docker
    docker-compose
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# use vim bindings for zsh
bindkey -v

files=(
    ".aliases" 
    ".functions" 
    ".xinitrc"
)

for file in ${files[@]}; do
    source $HOME/$file 2> /dev/null
done

source $ZSH/oh-my-zsh.sh
eval "$(pyenv init -)"
