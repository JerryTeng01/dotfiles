#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
BACKUP_DIR=""
UPDATE=0

usage() {
  cat <<'EOF'
Usage: ./install.sh [--update]

Install packages and link these dotfiles. --update also refreshes installed
packages, the Linux Neovim release, and mise-managed tools.
EOF
}

backup_path() {
  local target=$1 relative

  if [[ -z "$BACKUP_DIR" ]]; then
    BACKUP_DIR="$HOME/.local/state/dotfiles/backups/$(date +%Y%m%d-%H%M%S)"
  fi

  relative=${target#"$HOME"/}
  mkdir -p "$BACKUP_DIR/$(dirname -- "$relative")"
  mv -- "$target" "$BACKUP_DIR/$relative"
  printf 'Backed up %s to %s\n' "$target" "$BACKUP_DIR/$relative"
}

ensure_link() {
  local source=$1 target=$2 current

  mkdir -p "$(dirname -- "$target")"
  if [[ -L "$target" ]]; then
    current=$(readlink "$target")
    if [[ "$current" == "$source" ]]; then
      return
    fi
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    backup_path "$target"
  fi

  ln -s "$source" "$target"
  printf 'Linked %s -> %s\n' "$target" "$source"
}

remove_legacy_link() {
  local target=$1 current
  [[ -L "$target" ]] || return 0
  current=$(readlink "$target")
  case "$current" in
    "$DOTFILES_DIR"/*)
      rm "$target"
      printf 'Removed obsolete link %s\n' "$target"
      ;;
  esac
}

main() {
  local arg file fdfind_path

  for arg in "$@"; do
    case "$arg" in
      --update) UPDATE=1 ;;
      -h|--help) usage; return 0 ;;
      *) printf 'Unknown option: %s\n' "$arg" >&2; usage >&2; return 2 ;;
    esac
  done

  if (( UPDATE )); then
    "$DOTFILES_DIR/packages.sh" --update
  else
    "$DOTFILES_DIR/packages.sh"
  fi

  if [[ $(uname -s) == Darwin ]]; then
    DOTFILES_PLATFORM=macos
  else
    # packages.sh has already validated the Linux distribution and release.
    DOTFILES_PLATFORM=$(sed -n 's/^ID=//p' /etc/os-release | tr -d '"')
  fi
  export DOTFILES_PLATFORM

  for file in .aliases .functions .gitconfig .zshenv .zshrc; do
    ensure_link "$DOTFILES_DIR/$file" "$HOME/$file"
  done
  ensure_link "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
  ensure_link "$DOTFILES_DIR/.config/mise/config.toml" "$HOME/.config/mise/config.toml"
  ensure_link "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

  remove_legacy_link "$HOME/.vimrc"
  remove_legacy_link "$HOME/.tmux.conf"

  if [[ "$DOTFILES_PLATFORM" != macos ]] && ! command -v fd >/dev/null 2>&1; then
    fdfind_path=$(command -v fdfind || true)
    if [[ -n "$fdfind_path" ]]; then
      ensure_link "$fdfind_path" "$HOME/.local/bin/fd"
    fi
  fi

  if [[ "$DOTFILES_PLATFORM" != macos ]]; then
    ensure_link "$HOME/.local/opt/nvim/bin/nvim" "$HOME/.local/bin/nvim"
  fi

  mise install --yes
  if (( UPDATE )); then
    mise upgrade --yes
  fi

  printf '\nDotfiles installed. Start a new Zsh session with: exec zsh\n'
  if [[ -d "$HOME/.oh-my-zsh" ]]; then
    printf 'Oh My Zsh is no longer used; remove ~/.oh-my-zsh manually if desired.\n'
  fi
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  main "$@"
fi
