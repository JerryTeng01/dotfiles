if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'wakatime/vim-wakatime'
Plug 'sheerun/vim-polyglot'
Plug 'vimsence/vimsence'
Plug 'junegunn/goyo.vim'
Plug 'frazrepo/vim-rainbow'
Plug 'vim-airline/vim-airline'
Plug 'dense-analysis/ale'
Plug 'airblade/vim-gitgutter'
Plug 'vim-syntastic/syntastic'
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'

call plug#end()

syntax enable

set background=dark
let g:solarized_termcolors=256
colorscheme gruvbox

let g:rainbow_active = 1

set nu "rnu
set autoindent
set smartindent
set clipboard=unnamed
set ts=4 sw=4 sts=4 et
syntax enable
set autoindent
set cursorline
set showmatch
set nobackup
set swapfile
set dir=/tmp
set noeol
set visualbell
set t_vb=

