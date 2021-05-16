" install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'wakatime/vim-wakatime'
Plug 'franbach/miramare'
Plug 'sheerun/vim-polyglot'
Plug 'vimsence/vimsence'

call plug#end()

set termguicolors

" the configuration options should be placed before `colorscheme miramare`
let g:miramare_enable_italic = 1
let g:miramare_disable_italic_comment = 1
let g:airline_theme = 'miramare'

colorscheme miramare

set nu rnu
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

