# Dotfiles

Lean, cross-platform shell and editor configuration built around native Zsh,
[Starship](https://starship.rs/), [mise](https://mise.jdx.dev/), and
[LazyVim](https://www.lazyvim.org/).

## Supported platforms

- macOS on Intel or Apple Silicon, using Homebrew
- Ubuntu 24.04 on `x86_64` or `arm64`, using apt
- Debian 12 or newer on `x86_64` or `arm64`, using apt

Other Linux distributions, older Ubuntu releases, and Debian 11 or older exit
without making changes. The installer may request `sudo` on apt-based systems
for package and repository setup. Neovim and mise runtimes remain user-local.

## Install

```sh
git clone https://github.com/JerryTeng01/dotfiles.git ~/code/dotfiles
cd ~/code/dotfiles
./install.sh
exec zsh
```

`install.sh` first runs the standalone `packages.sh`, then creates symlinks.
Conflicting files are moved to
`~/.local/state/dotfiles/backups/<timestamp>` before linking. A second run is
safe and does not back up or relink files that are already correct.

The installer does not uninstall old software or data. In particular, an
existing `~/.oh-my-zsh` is unused but left in place. Remove it manually only
after confirming that no other configuration needs it:

```sh
rm -rf ~/.oh-my-zsh
```

## Updates

Refresh system packages, the stable Linux Neovim tarball, and mise tools with:

```sh
cd ~/code/dotfiles
git pull --ff-only
./install.sh --update
```

Projects can override the global Node 24 and Python 3.14 defaults with their
own `mise.toml`. Plugin versions are recorded in Neovim's `lazy-lock.json`;
update them intentionally from `:Lazy` and commit the changed lock file.

## Linux over SSH and Codex

The Ubuntu and Debian installations are suitable for a headless SSH host.
Configure your local terminal to use a Nerd Font for icons; no font is
installed on the server. JetBrains Mono Nerd Font is installed automatically
on macOS.

Clone the repository on the remote host, run `./install.sh`, and reconnect (or
run `exec zsh`). Codex can then be launched inside a project normally. Keep
long-running SSH work in tmux so it survives a dropped connection:

```sh
tmux new -s work
cd ~/code/my-project
codex
```

## Neovim

Ubuntu and Debian receive the latest stable official Neovim tarball under
`~/.local/opt/nvim`; its GitHub-published SHA-256 digest is verified before it
is installed and `~/.local/bin/nvim` exposes it. macOS uses Homebrew. LazyVim
requires Neovim 0.11.2 or newer and enables its Python language extra, Gruvbox,
and no additional UI, AI, debugging, or GitHub extras.
