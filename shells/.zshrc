DEFAULT_USER=jerryteng
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="random"
ENABLE_CORRECTION="true"
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh

#source /usr/bin/bash-wakatime/bash-wakatime.sh

[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.funs ] && source ~/.funs
[ -f ~/.git_aliases ] && source ~/.git_aliases
#[ -f ~/.gdbinit ] && source ~/.gdbinit
