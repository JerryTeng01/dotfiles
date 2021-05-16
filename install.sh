#!/bin/bash

if [ ! -d ~/.oh-my-zsh ]; then
    curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
fi

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# vim
ln -sf $HOME/dotfiles/.vimrc ~

# git 
ln -sf $HOME/dotfiles/.gitconfig ~
ln -sf $HOME/dotfiles/.git_aliases ~

# shell 
ln -sf $HOME/dotfiles/.zshrc ~
ln -sf $HOME/dotfiles/.functions ~
ln -sf $HOME/dotfiles/.aliases ~
ln -sf $HOME/dotfiles/.profile ~

# gdb 
ln -sf $HOME/dotfiles/.gdbinit ~

