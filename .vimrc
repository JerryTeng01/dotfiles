let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#begin('~/.vim/plugged')

Plug 'wakatime/vim-wakatime'
Plug 'vimsence/vimsence'
Plug 'frazrepo/vim-rainbow'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'

call plug#end()

" colors
set t_Co=256
set background=dark
colorscheme gruvbox

let g:rainbow_active = 1

" options
set nu "rnu
set autoindent
set smartindent
set clipboard=unnamed
set ts=4 sw=4 sts=4 et
syntax on
set autoindent
set cursorline
set showmatch
set nobackup
set swapfile
set dir=/tmp
set noeol
set ignorecase
set smartcase
set visualbell
set t_vb=
filetype indent plugin on
