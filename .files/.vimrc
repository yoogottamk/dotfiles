"  Vundle stuff {{{

set nocp

filetype off
set rtp+=/home/yog/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'gko/vim-coloresque'

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
Plugin 'shime/vim-livedown'
Plugin 'junegunn/fzf.vim'
Plugin 'bronson/vim-visual-star-search'

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

set backspace=indent,eol,start
" update file if content changed outside
set autoread

" remove all extra stuff from gvim
set go-=r
set go-=R
set go-=l
set go-=L
set go-=m
set go-=T

" disable swapfile
set nobackup noswapfile nowb

set autoindent smartindent

set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set softtabstop=4

set hlsearch
set incsearch
set ignorecase smartcase

set undolevels=999 history=999

set t_Co=256
set background=dark
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

set laststatus=2
set shortmess+=I

" show splits on the right and below
set spr sb

set viminfo='100,<1000,s100,h

"  }}}

"  netrw {{{

let g:netrw_banner=0

" }}}

" ale {{{

let g:ale_sign_error=">>"
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\   'html': ['prettier'],
\}

" }}}

" NERDTree {{{

nnoremap <leader>nt :NERDTree<CR>

" }}}

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

" easier code folding
nnoremap <space><space> za

" cd to dir containing this file
nnoremap <leader>cd :cd %:p:h<cr>

" move (selected) line(s) up or down
nnoremap <silent> + :m .+1<CR>==
nnoremap <silent> - :m .-2<CR>==
vnoremap <silent> + :m '>+1<CR>gv=gv
vnoremap <silent> - :m '<-2<CR>gv=gv

" quickfix maps
nnoremap ]q :cnext<cr>
nnoremap [q :cprev<cr>
nnoremap [Q :cfirst<cr>
nnoremap ]Q :clast<cr>

" location list maps
nnoremap ]l :lnext<cr>
nnoremap [l :lprev<cr>
nnoremap [L :lfirst<cr>
nnoremap ]L :llast<cr>

tnoremap <Esc> <C-\><C-n>

" }}}

"  AirLine {{{

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

"  }}}

" YCM {{{

let g:ycm_global_ycm_extra_conf="~/.vim/.ycm_extra_conf.py"
let g:ycm_server_python_interpreter='/usr/bin/python3'
let g:ycm_always_populate_location_list = 1

" }}}

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

so ~/.vim/bundle/vim-commenter/vim-commenter.vim

" }}}

" fzf {{{

set rtp+=~/.fzf

" }}}

" autocmds {{{

if has("autocmd")
    " jump to the last known location
    augroup vimStartup
        au!
        autocmd BufReadPost *
          \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
          \ |   exe "normal! g`\""
          \ | endif
    augroup END

    " vim pretty display md
    augroup markDown
        au!
        autocmd BufReadPre *.md setlocal conceallevel=2
    augroup end

    augroup nerdtreeClear
        au!
        autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | bd | endif
    augroup end

    augroup filetypeVim
        au!
        autocmd FileType vim setlocal foldmethod=marker
    augroup end

    augroup emmetEnable
        au!
        autocmd FileType html,css,php,javascript.jsx EmmetInstall
    augroup end

    augroup sourceVimrc
        au!
        autocmd BufWritePost .vimrc source ~/.vimrc
    augroup end
endif

" }}}

" misc functions{{{

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" }}}
