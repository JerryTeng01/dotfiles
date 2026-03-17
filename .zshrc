export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"
# ZSH_THEME="cloud"
#ZSH_THEME="lambda"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# use vim bindings for zsh
bindkey -v

# automatically updates Oh My Zsh when a new version is available, without asking for confirmation
zstyle ':omz:update' mode auto
# shows only the git update process and a minimal success message
zstyle ':omz:update' verbose minimal

files=(
    ".aliases"
    ".functions"
)

for file in ${files[@]}; do
    source $HOME/$file 2> /dev/null
done

source $ZSH/oh-my-zsh.sh

prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "🐱 %n@%m"
  else
    prompt_segment black default "🐱"
  fi
}

DEFAULT_USER=$USER
