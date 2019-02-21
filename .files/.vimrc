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
Plugin 'tpope/vim-surround'
Plugin 'SirVer/ultisnips'
Plugin 'ervandew/supertab'

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

set ai si

set et
set smarttab
set sw=4
set ts=4

set hls
set is
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
    set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 16
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
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | bd | endif
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
nnoremap <leader>h :bp!<CR>
nnoremap <leader>l :bn!<CR>

" for saving files normally
inoremap <C-s> <Esc>:w<CR>a
nnoremap <C-s> :w<CR>

" for quitting faster
nnoremap <leader>q :bd<CR>
nnoremap <leader>x :x<CR>

" Useful
nnoremap H ^
nnoremap L $

nnoremap <F2> :ls<CR>:b

noremap <unique> <M-1> 1gt
noremap <unique> <M-2> 2gt
noremap <unique> <M-3> 3gt
noremap <unique> <M-4> 4gt
noremap <unique> <M-5> 5gt
noremap <unique> <M-6> 6gt
noremap <unique> <M-7> 7gt
noremap <unique> <M-8> 8gt
noremap <unique> <M-9> 9gt
noremap <unique> <M-0> 10gt

inoremap <unique> <M-1> <C-O>1gt
inoremap <unique> <M-2> <C-O>2gt
inoremap <unique> <M-3> <C-O>3gt
inoremap <unique> <M-4> <C-O>4gt
inoremap <unique> <M-5> <C-O>5gt
inoremap <unique> <M-6> <C-O>6gt
inoremap <unique> <M-7> <C-O>7gt
inoremap <unique> <M-8> <C-O>8gt
inoremap <unique> <M-9> <C-O>9gt
inoremap <unique> <M-0> <C-O>10gt

" edit .vimrc
nnoremap <leader>ev :vs ~/.vimrc<cr>

" src .vimrc
nnoremap <leader>sv :so ~/.vimrc<cr>

" easier on code folding
nnoremap <space><space> za

" }}}

"  custom
set laststatus=2
set shortmess+=I
let g:ale_set_highlights=0

"  AirLine stuff {{{

let g:airline#extensions#tabline#enabled=1
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
let g:ycm_enable_diagnostic_signs=0
let g:ycm_enable_diagnostic_highlighting=0
"  }}}

" YCM + UltiSnips {{{
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" }}}

" UltiSnips
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']

