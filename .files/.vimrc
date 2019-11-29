"  vim-plug stuff {{{

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/NERDTree'
Plug 'jiangmiao/auto-pairs'
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'
Plug 'mattn/emmet-vim'
Plug 'lervag/vimtex'
Plug 'shime/vim-livedown'
Plug 'junegunn/fzf.vim'
Plug 'thosakwe/vim-flutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'srcery-colors/srcery-vim'

" language syntax
Plug 'udalov/kotlin-vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'dart-lang/dart-vim-plugin'
Plug 'gootorov/q-sharp.vim'

call plug#end()

"  }}}

" {{{ internal vim packages
packadd termdebug
packadd matchit
" }}}

"  Basic vim settings {{{
set nu rnu

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
nnoremap <F7> :setlocal spell! spelllang=en<CR>
nnoremap <F6> :Termdebug %:r<CR>
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" for split navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
tnoremap <C-j> <C-w>j
tnoremap <C-k> <C-w>k
tnoremap <C-h> <C-w>h
tnoremap <C-l> <C-w>l

" for buffer navigation
nnoremap <C-tab> :bn!<CR>
nnoremap <C-S-tab> :bp!<CR>
nnoremap <leader>l :bn!<CR>
nnoremap <leader>h :bp!<CR>

" for tab navigation
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>
nnoremap ]T :tabl<cr>
nnoremap [T :tabr<cr>
tnoremap ]t <C-\><C-n>:tabn<cr>
tnoremap [t <C-\><C-n>:tabp<cr>
tnoremap ]T <C-\><C-n>:tabl<cr>
tnoremap [T <C-\><C-n>:tabr<cr>

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

" TODO: change this later
" nnoremap <C-f> :YcmCompleter FixIt<CR>
" inoremap <C-f> <c-g>u<Esc>:YcmCompleter FixIt<CR>a<c-g>u
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

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

" UltiSnips {{{
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
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

" coc {{{
source ~/.config/nvim/coc-init.vim
" }}}
