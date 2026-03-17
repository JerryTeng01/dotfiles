#!/bin/bash

if [ ! -d ~/.oh-my-zsh ]; then
    curl -L https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh
fi

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

fonts=(
    font-source-code-pro
)
for font in "${fonts[@]}"; do
    if brew list --cask "$font" &>/dev/null; then
        echo "✓ $font"
    else
        echo "Installing $font..."
        brew install --cask "$font"
    fi
done

files=(
    ".aliases"
    ".functions"
    ".gitconfig"
    ".themes"
    ".tmux.conf"
    ".vimrc"
    ".zshenv"
    ".zshrc"
)

for file in ${files[@]}; do ln -sfv $PWD/$file $HOME
done

if [ ! -d $HOME/.vim/undodir ]; then
    mkdir -p $HOME/.vim/undodir
fi
