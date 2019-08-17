"  Vundle stuff --- {{{

set nocp

filetype off
set rtp+=/home/yog/.vim/bundle/Vundle.vim

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
Plugin 'tpope/vim-surround'
Plugin 'SirVer/ultisnips'
Plugin 'ervandew/supertab'
Plugin 'mattn/emmet-vim'
Plugin 'lervag/vimtex'
Plugin 'junegunn/fzf.vim'

" language syntax
Plugin 'udalov/kotlin-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

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

let g:airline_theme='solarized_flood'

if has("gui_running")
    set bg=dark
    colo solarized
    set lines=999 columns=999
    set guifont=Inconsolata\ for\ Powerline\ 16
    let g:airline_theme='deus'
    let g:ale_set_highlights=1
    set cursorline
endif

set noshowmode
set showcmd

set spr
set sb

set viminfo='100,<1000,s100,h

"  }}}

"  netrw {{{
let g:netrw_banner=0
" }}}

" {{{ ale
let g:ale_sign_error=">>"
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\   'html': ['prettier'],
\}
" }}}

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
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" for split navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" for buffer navigation
nnoremap <C-tab> :bn!<CR>
nnoremap <C-S-tab> :bp!<CR>
nnoremap <leader>l :bn!<CR>
nnoremap <leader>h :bp!<CR>

" for doing some things faster
nnoremap <leader>q :bd<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>w :w<CR>

" Useful
nnoremap H ^
nnoremap L $
nnoremap <leader><space> :noh<cr>

" fzf
nnoremap <F2> :Buffers<cr>
nnoremap <leader>o :Files<cr>

" edit .vimrc
nnoremap <leader>ev :vs ~/.vimrc<cr>
" src .vimrc
nnoremap <leader>sv :so ~/.vimrc<cr>

" easier on code folding
nnoremap <space><space> za

inoremap <F8> <esc>:cd %:p:h<cr>
nnoremap <F8> :cd %:p:h<cr>

" move (selected) line(s) up or down
nnoremap <silent> + :m .+1<CR>==
nnoremap <silent> - :m .-2<CR>==
vnoremap <silent> + :m '>+1<CR>gv=gv
vnoremap <silent> - :m '<-2<CR>gv=gv

tnoremap <Esc> <C-\><C-n>
" }}}

" {{{ custom
set laststatus=2
set shortmess+=I
" }}}

"  AirLine stuff {{{

let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
let g:airline#extensions#ale#enabled=1

"  }}}

"  Emmet {{{

let g:user_emmet_leader_key=','
let g:user_emmet_install_global = 0

let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}

augroup emmet_enable
    autocmd!
    autocmd FileType html,css,php,javascript.jsx  EmmetInstall
augroup end

"  }}}

"  YCM  {{{
let g:ycm_global_ycm_extra_conf="~/.vim/.ycm_extra_conf.py"
let g:ycm_server_python_interpreter='/usr/bin/python3'
"  }}}

" YCM + UltiSnips {{{
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" }}}

" UltiSnips {{{
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']

let g:UltiSnipsEditSplit="vertical"
" }}}

" vimtex {{{
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
" }}}

" My own commenter {{{
so /home/yog/.vim/bundle/vim-commenter/vim-commenter.vim
" }}}

" {{{ fzf
set rtp+=~/.fzf
" }}}

" {{{ jump to the last known location
augroup vimStartup
    au!

    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif
augroup END
" }}}

" {{{ vim pretty display md
augroup md
    au!

    autocmd BufReadPre *.md setlocal conceallevel=2
augroup end
" }}}
