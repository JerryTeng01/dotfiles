#!/usr/bin/env bash

set -euo pipefail

UPDATE=0
DOTFILES_PLATFORM=""

usage() {
  cat <<'EOF'
Usage: ./packages.sh [--update]

Install the supported platform's packages. Supported systems are macOS,
Ubuntu 24.04, and Debian 12 or newer. Set DOTFILES_OS_RELEASE_FILE or
DOTFILES_ARCH when testing detection without changing the host.
EOF
}

detect_platform() {
  local kernel os_release id version_id version_major
  kernel=${DOTFILES_UNAME_S:-$(uname -s)}

  if [[ "$kernel" == Darwin ]]; then
    DOTFILES_PLATFORM=macos
    export DOTFILES_PLATFORM
    return
  fi

  if [[ "$kernel" == Linux ]]; then
    os_release=${DOTFILES_OS_RELEASE_FILE:-/etc/os-release}
    if [[ ! -r "$os_release" ]]; then
      printf 'Unsupported Linux system: %s is unavailable. Use Ubuntu 24.04 or Debian 12+.\n' "$os_release" >&2
      return 1
    fi
    id=$(sed -n 's/^ID=//p' "$os_release" | tr -d '"')
    version_id=$(sed -n 's/^VERSION_ID=//p' "$os_release" | tr -d '"')
    if [[ "$id" == ubuntu && "$version_id" == 24.04 ]]; then
      DOTFILES_PLATFORM=ubuntu
      export DOTFILES_PLATFORM
      return
    fi
    version_major=${version_id%%.*}
    if [[ "$id" == debian && "$version_major" =~ ^[0-9]+$ ]] && (( version_major >= 12 )); then
      DOTFILES_PLATFORM=debian
      export DOTFILES_PLATFORM
      return
    fi
    printf 'Unsupported Linux distribution: %s %s. Use Ubuntu 24.04 or Debian 12+.\n' "$id" "$version_id" >&2
    return 1
  fi

  printf 'Unsupported operating system: %s. Use macOS, Ubuntu 24.04, or Debian 12+.\n' "$kernel" >&2
  return 1
}

nvim_asset_for_arch() {
  case "${DOTFILES_ARCH:-$(uname -m)}" in
    x86_64|amd64) printf '%s\n' nvim-linux-x86_64.tar.gz ;;
    arm64|aarch64) printf '%s\n' nvim-linux-arm64.tar.gz ;;
    *)
      printf 'Unsupported Linux architecture: %s. Use x86_64 or arm64.\n' "${DOTFILES_ARCH:-$(uname -m)}" >&2
      return 1
      ;;
  esac
}

install_brew_packages() {
  local formula cask
  local -a formulae=(
    cmake curl fd gcc git htop make mise neovim pkg-config ripgrep tmux
    unzip xz zsh zsh-autosuggestions zsh-syntax-highlighting
  )
  local -a casks=(font-jetbrains-mono-nerd-font)

  if ! command -v brew >/dev/null 2>&1; then
    printf 'Homebrew is not installed; installing it now.\n'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ -x /opt/homebrew/bin/brew ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x /usr/local/bin/brew ]]; then
      eval "$(/usr/local/bin/brew shellenv)"
    fi
  fi

  for formula in "${formulae[@]}"; do
    if ! brew list --formula "$formula" >/dev/null 2>&1; then
      brew install "$formula"
    fi
  done
  for cask in "${casks[@]}"; do
    if ! brew list --cask "$cask" >/dev/null 2>&1; then
      brew install --cask "$cask"
    fi
  done

  if (( UPDATE )); then
    brew update
    brew upgrade "${formulae[@]}"
    brew upgrade --cask "${casks[@]}" || true
  fi
}

run_as_root() {
  if [[ ${EUID:-$(id -u)} -eq 0 ]]; then
    "$@"
  elif command -v sudo >/dev/null 2>&1; then
    sudo "$@"
  else
    printf 'This step needs root access, but sudo is not installed: %s\n' "$*" >&2
    return 1
  fi
}

apt_install_missing() {
  local package
  local -a missing=()
  for package in "$@"; do
    if ! dpkg-query -W -f='${Status}' "$package" 2>/dev/null | grep -q 'ok installed'; then
      missing+=("$package")
    fi
  done
  if (( ${#missing[@]} )); then
    run_as_root env DEBIAN_FRONTEND=noninteractive apt-get install -y "${missing[@]}"
  fi
}

apt_has_missing() {
  local package
  for package in "$@"; do
    if ! dpkg-query -W -f='${Status}' "$package" 2>/dev/null | grep -q 'ok installed'; then
      return 0
    fi
  done
  return 1
}

configure_mise_apt_repo() {
  local tmp
  run_as_root install -d -m 0755 /etc/apt/keyrings
  if [[ ! -s /etc/apt/keyrings/mise-archive-keyring.pub ]]; then
    tmp=$(mktemp)
    curl -fsSL https://mise.jdx.dev/gpg-key.pub -o "$tmp"
    run_as_root install -m 0644 "$tmp" /etc/apt/keyrings/mise-archive-keyring.pub
    rm -f -- "$tmp"
  fi
  if [[ ! -s /etc/apt/sources.list.d/mise.list ]]; then
    tmp=$(mktemp)
    printf '%s\n' 'deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.pub] https://mise.jdx.dev/deb stable main' >"$tmp"
    run_as_root install -m 0644 "$tmp" /etc/apt/sources.list.d/mise.list
    rm -f -- "$tmp"
  fi
}

version_at_least() {
  local actual=$1 required=$2 first
  first=$(printf '%s\n%s\n' "$required" "$actual" | sort -V | head -n 1)
  [[ "$first" == "$required" ]]
}

install_neovim_linux() (
  local install_root="$HOME/.local/opt/nvim"
  local installed_version="" asset release_json tag digest url archive staging

  if [[ -x "$install_root/bin/nvim" ]]; then
    installed_version=$($install_root/bin/nvim --version | sed -n '1s/^NVIM v//p')
  fi
  if [[ -n "$installed_version" ]] && version_at_least "$installed_version" 0.11.2 && (( ! UPDATE )); then
    return
  fi

  asset=$(nvim_asset_for_arch)
  release_json=$(mktemp)
  archive=$(mktemp)
  staging=$(mktemp -d)
  trap 'rm -f -- "${release_json:-}" "${archive:-}"; rm -rf -- "${staging:-}"' EXIT

  curl -fsSL https://api.github.com/repos/neovim/neovim/releases/latest -o "$release_json"
  tag=$(jq -r '.tag_name' "$release_json")
  digest=$(jq -r --arg name "$asset" '.assets[] | select(.name == $name) | .digest' "$release_json")
  url=$(jq -r --arg name "$asset" '.assets[] | select(.name == $name) | .browser_download_url' "$release_json")
  if [[ -z "$tag" || "$tag" == null || ! "$digest" =~ ^sha256:[0-9a-f]{64}$ || -z "$url" || "$url" == null ]]; then
    printf 'Could not resolve a checksummed stable Neovim asset for %s.\n' "$asset" >&2
    return 1
  fi
  if [[ -n "$installed_version" && "v$installed_version" == "$tag" ]]; then
    return
  fi

  curl -fL "$url" -o "$archive"
  printf '%s  %s\n' "${digest#sha256:}" "$archive" | sha256sum -c -
  tar -xzf "$archive" -C "$staging" --strip-components=1
  if ! version_at_least "$($staging/bin/nvim --version | sed -n '1s/^NVIM v//p')" 0.11.2; then
    printf 'The current stable Neovim release is older than 0.11.2.\n' >&2
    return 1
  fi
  mkdir -p "$(dirname -- "$install_root")"
  rm -rf -- "$install_root"
  mv -- "$staging" "$install_root"
  staging=""
)

expose_user_command() {
  local source=$1 target=$2 current
  mkdir -p "$(dirname -- "$target")"
  if [[ -L "$target" ]]; then
    current=$(readlink "$target")
    [[ "$current" == "$source" ]] && return
  fi
  if [[ -e "$target" || -L "$target" ]]; then
    printf 'Leaving existing %s unchanged; install.sh will back it up before linking.\n' "$target" >&2
    return
  fi
  ln -s "$source" "$target"
}

install_apt_packages() {
  local -a bootstrap=(ca-certificates curl gnupg)
  local -a packages=(
    build-essential cmake fd-find git htop jq pkg-config ripgrep tar tmux unzip
    xz-utils zsh zsh-autosuggestions zsh-syntax-highlighting
  )

  if apt_has_missing "${bootstrap[@]}"; then
    run_as_root apt-get update
    apt_install_missing "${bootstrap[@]}"
  fi
  configure_mise_apt_repo
  if apt_has_missing "${packages[@]}" mise; then
    run_as_root apt-get update
    apt_install_missing "${packages[@]}" mise
  fi
  if (( UPDATE )); then
    run_as_root apt-get update
    run_as_root env DEBIAN_FRONTEND=noninteractive apt-get install -y --only-upgrade "${packages[@]}" mise
  fi
  install_neovim_linux
  expose_user_command "$(command -v fdfind)" "$HOME/.local/bin/fd"
  expose_user_command "$HOME/.local/opt/nvim/bin/nvim" "$HOME/.local/bin/nvim"
}

main() {
  local arg
  for arg in "$@"; do
    case "$arg" in
      --update) UPDATE=1 ;;
      -h|--help) usage; return 0 ;;
      *) printf 'Unknown option: %s\n' "$arg" >&2; usage >&2; return 2 ;;
    esac
  done

  detect_platform
  case "$DOTFILES_PLATFORM" in
    macos) install_brew_packages ;;
    ubuntu|debian) install_apt_packages ;;
  esac
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  main "$@"
fi
