DEFAULT_USER=jerryteng
export ZSH="$HOME/.oh-my-zsh"
#ZSH_THEME="random"
#plugins=(
#  git
#  zsh-syntax-highlighting
#  zsh-autosuggestions
#)

# use vim bindings for zsh
bindkey -v

source $ZSH_HOME/.oh-my-zsh
#source ~/.antigen/antigen.zsh

#antigen use oh-my-zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-autosuggestions
antigen apply
antigen theme robbyrussell

[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.funs ] && source ~/.funs
#[ -f ~/.gdbinit ] && source ~/.gdbinit
