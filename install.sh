#!/bin/bash

# vim symlinks
ln -sf $HOME/dotfiles/vim/.vimrc $HOME/.vimrc

# git symlinks
ln -sf $HOME/dotfiles/git/.gitconfig $HOME/.gitconfig
ln -sf $HOME/dotfiles/git/.git_aliases $HOME/.git_aliases

# shell symlinks
ln -sf $HOME/dotfiles/shells/.aliases $HOME/.aliases
ln -sf $HOME/dotfiles/shells/.zshrc $HOME/.zshrc
ln -sf $HOME/dotfiles/shells/.funs $HOME/.funs
ln -sf $HOME/dotfiles/shells/.aliases $HOME/.aliases
ln -sf $HOME/dotfiles/shells/.profile $HOME/.profile

# gdb symlinks
ln -sf $HOME/dotfiles/gdb/.gdbinit $HOME/.gdbinit

