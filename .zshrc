cd ~
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

# use vim bindings for zsh
bindkey -v

source $ZSH/oh-my-zsh.sh

files=(".aliases", ".functions", ".gdbinit", ".profile")

for file in $files; do
    source $file 2> /dev/null
done

