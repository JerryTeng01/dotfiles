export ZSH="$HOME/.oh-my-zsh"
#ZSH_THEME="lambda"
#ZSH_THEME="muse"
#ZSH_THEME="simple"
#ZSH_THEME="arrow"
#ZSH_THEME="cloud"
ZSH_THEME="lambda"
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

# use vim bindings for zsh
bindkey -v

source $ZSH/oh-my-zsh.sh

files=(".aliases" ".functions" ".xinitrc")

for file in ${files[@]}; do
    source $HOME/$file 2> /dev/null
done

