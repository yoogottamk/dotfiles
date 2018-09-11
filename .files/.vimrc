set nocp

"  vundle stuff

filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/NERDTree'
Plugin 'jiangmiao/auto-pairs'
Plugin 'w0rp/ale'
Plugin 'tpope/vim-fugitive'
Plugin 'mattn/emmet-vim'

call vundle#end()

"  vundle stuff ends

filetype plugin indent on
syntax enable
set nu rnu

let mapleader=","

set backspace=indent,eol,start
set autoread

set go-=r
set go-=R
set go-=l
set go-=L
set go-=m
set go-=T

set nobackup
set noswapfile
set nowb

set autoindent
set smartindent

set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

set hlsearch
set incsearch
set ignorecase
set smartcase

set undolevels=999
set history=999

set background=dark
set t_Co=256
colo desert

let g:airline_theme='cool'
let g:ale_set_highlights=0

if has("gui_running")
    set bg=dark
    colo solarized
    set lines=999 columns=999
    set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 14
    let g:airline_theme='deus'
    let g:ale_set_highlights=1
    set cursorline
endif

set noshowmode
set showcmd
set shortmess+=I

"  netrw
let g:netrw_banner=0

"  NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"  maps
nmap <F6> :setlocal spell spelllang=en<CR>

map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

map <leader>h gT
map <leader>l gt

imap <C-s> <Esc>:w<CR>a
nmap <C-s> :w<CR>

nmap <leader>nt :NERDTree<CR>

nmap <leader>tq :tabclose<CR>

"  custom
let g:airline#extensions#ale#enabled=1
let g:ycm_global_ycm_extra_conf="~/.vim/.ycm_extra_conf.py"
set laststatus=2

"  airline stuff
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_powerline_fonts = 1

"  emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css  EmmetInstall
autocmd FileType html,css imap <TAB> <plug>(emmet-expand-abbr)
