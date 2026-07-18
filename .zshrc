# History
typeset -g ZDOTDIR=${ZDOTDIR:-$HOME}
typeset -g HISTFILE=${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history
mkdir -p "${HISTFILE:h}"
HISTSIZE=50000
SAVEHIST=10000
setopt append_history extended_history hist_expire_dups_first hist_ignore_dups
setopt hist_reduce_blanks share_history

# Completion
autoload -Uz compinit
zcompdump=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION
mkdir -p "${zcompdump:h}"
compinit -d "$zcompdump"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completion"
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completion"

# Vim-style command-line editing
bindkey -v
KEYTIMEOUT=1

for file in "$HOME/.aliases" "$HOME/.functions"; do
  [[ -r "$file" ]] && source "$file"
done
unset file

# Load package-manager plugins without assuming a Homebrew prefix.
for plugin in \
  /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
  /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
  /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh; do
  if [[ -r "$plugin" ]]; then
    source "$plugin"
    break
  fi
done
unset plugin

# Runtime activation must precede the prompt so it can report active versions.
if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
fi
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

# Syntax highlighting must be sourced after every widget and prompt integration.
for plugin in \
  /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; do
  if [[ -r "$plugin" ]]; then
    source "$plugin"
    break
  fi
done
unset plugin
