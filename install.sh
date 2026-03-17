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

if [ ! -f "$HOME/Library/Fonts/SourceCodePro-Medium.otf" ]; then
    mkdir /tmp/adodefont
    curl -fLo /tmp/adodefont/SourceCodePro.zip https://github.com/adobe-fonts/source-code-pro/releases/latest/download/OTF-source-code-pro.zip
    unzip /tmp/adodefont/SourceCodePro.zip -d /tmp/adodefont/
    mkdir -p ~/Library/Fonts
    cp /tmp/adodefont/OTF/*.otf ~/Library/Fonts/
    rm -rf /tmp/adodefont
fi

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

[ -d $HOME/.config/alacritty ] && rm -fr $HOME/.config/alacritty
ln -sf $(pwd)/config/alacritty $HOME/.config/alacritty
