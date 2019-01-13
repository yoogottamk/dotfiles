"  Vundle stuff --- {{{

set nocp

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

"  }}}

"  Basic vim settings {{{

filetype plugin indent on
syntax enable
set nu rnu

let mapleader=","

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup end

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

"  }}}

"  netrw
let g:netrw_banner=0

"  NERDTree {{{

augroup nerdtree_clear
    autocmd!
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup end

nnoremap <leader>nt :NERDTree<CR>

"  }}}

"  maps {{{

" for spellings
nnoremap <F6> :setlocal spell spelllang=en<CR>
nnoremap <F7> :set nospell<CR>

" for split navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" for tab navigation
nnoremap <leader>h gT
nnoremap <leader>l gt

nnoremap <leader>tq :tabclose<CR>

" for saving files normally
inoremap <C-s> <Esc>:w<CR>a
nnoremap <C-s> :w<CR>

" for quitting faster
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>


" Moves current line ine line below
nnoremap - O<esc>cc<Esc>j

" Moves current line one line above
nnoremap _ o<esc>k

" C-d to delete line in insert mode
inoremap <C-d> <esc>dda

" edit .vimrc
nnoremap <leader>ev :vs ~/.vimrc<cr>

" src .vimrc
nnoremap <leader>sv :so ~/.vimrc<cr>

" useful surrounds
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
nnoremap <leader>( viw<esc>a(<esc>bi)<esc>lel
nnoremap <leader>[ viw<esc>a[<esc>bi]<esc>lel

vnoremap <leader>" <esc>`<i"<esc>`>a"<esc>l
vnoremap <leader>' <esc>`<i'<esc>`>a'<esc>l
vnoremap <leader>( <esc>`<i(<esc>`>a)<esc>l
vnoremap <leader>[ <esc>`<i[<esc>`>a]<esc>l

" }}}

"  custom
set laststatus=2
set shortmess+=I
let g:ale_set_highlights=0

"  AirLine stuff {{{

let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#show_buffers=0
let g:airline_powerline_fonts=1
let g:airline#extensions#ale#enabled=1

"  }}}

"  Emmet {{{

let g:user_emmet_install_global=0

augroup emmet_enable
    autocmd!
    autocmd FileType html,css,php  EmmetInstall
augroup end

let g:user_emmet_leader_key=','

"  }}}

"  YCM  {{{
let g:ycm_global_ycm_extra_conf="~/.vim/.ycm_extra_conf.py"
"  }}}
