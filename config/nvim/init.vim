set runtimepath^=~/.vim
let &packpath = &runtimepath

" vim-plug stuff {{{
call plug#begin(stdpath('data') . '/plugged')

Plug 'vim-airline/vim-airline'
Plug 'srcery-colors/srcery-vim'

Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'hrsh7th/nvim-compe'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim', { 'do': 'wget https://web.iiit.ac.in/~yoogottam.khandelwal/lspsaga.patch && git apply lspsaga.patch' }
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mattn/efm-langserver'

Plug 'google/vim-maktaba'
Plug 'google/vim-coverage'
Plug 'google/vim-glaive'

Plug 'tmhedberg/SimpylFold'

Plug 'SirVer/ultisnips'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'rmagatti/auto-session'
Plug 'mattn/emmet-vim'
Plug 'lervag/vimtex'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'thosakwe/vim-flutter'

Plug 'dart-lang/dart-vim-plugin'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'cespare/vim-toml'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
call plug#end()
" }}}

" {{{ internal vim packages
packadd matchit
" }}}

" Basic vim settings {{{
" line numbers and relative line numbers
set nu rnu

" update file if content changed outside
set autoread

set autoindent smartindent

set expandtab smarttab
set shiftwidth=4
set tabstop=4
set softtabstop=4

set hlsearch incsearch ignorecase smartcase

" nice persistent undo
set undolevels=999 history=999
set undofile
set undodir=~/.vim/undodir

" theme
set t_Co=256
set background=dark
let g:airlinetheme="srcery"
colo srcery
let g:srcery_italic = 1
let g:srcery_transparent_background = 1
set termguicolors
hi Normal guibg=NONE ctermbg=NONE

" airline already shows this
set noshowmode

set showcmd
set laststatus=2

" I disables the vim intro message
" c disables insertion complete menu messages
set shortmess+=Ic

" show splits on the right and below
set spr sb

set viminfo='100,<1000,s100,h

set cursorline
let mapleader=" "
let g:netrw_banner=0
set dictionary+=/usr/share/dict/words

let g:python3_host_prog='/usr/bin/python'

" for live-previewing effects of commands, mostly for :s
set inccommand=nosplit

set completeopt=menuone,noselect,noinsert,preview
set updatetime=300

set signcolumn=number
" }}}

"  maps {{{
" for spellings
nnoremap <F7> :setlocal spell! spelllang=en<CR>
inoremap <C-l> <c-g>u<Esc>[s1z=`]i<c-g>u

" for split navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
tnoremap <C-j> <C-w>j
tnoremap <C-k> <C-w>k
tnoremap <C-h> <C-w>h
" tnoremap <C-l> <C-w>l

" for doing some things faster
nnoremap <leader>q :bd<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>w :w<CR>

" Useful
nnoremap H ^
nnoremap L $
nnoremap <leader><space> :noh<cr>

" fzf
nnoremap <F2> <cmd>Buffers<cr>
nnoremap <leader>l <cmd>Files<cr>

" edit init.vim
nnoremap <leader>ev :vs ~/.config/nvim/init.vim<cr>

" make commenting easier
nnoremap <leader>/ :Commentary<cr>
vnoremap <leader>/ :Commentary<CR>

" cd to dir containing this file
nnoremap <leader>cd :cd %:p:h<cr>

" move (selected) line(s) up or down
nnoremap <silent> + :m .+1<CR>==
nnoremap <silent> - :m .-2<CR>==
vnoremap <silent> + :m '>+1<CR>gv=gv
vnoremap <silent> - :m '<-2<CR>gv=gv

" for tab navigation
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>
nnoremap ]T :tabl<cr>
nnoremap [T :tabr<cr>
tnoremap ]t <C-\><C-n>:tabn<cr>
tnoremap [t <C-\><C-n>:tabp<cr>
tnoremap ]T <C-\><C-n>:tabl<cr>
tnoremap [T <C-\><C-n>:tabr<cr>

" for buffer navigation
nnoremap ]b :bn!<cr>
nnoremap [b :bp!<cr>
nnoremap ]B :bfirst!<cr>
nnoremap ]B :blast!<cr>
tnoremap ]b <C-\><C-n>:bn!<cr>
tnoremap [b <C-\><C-n>:bp!<cr>
tnoremap ]B <C-\><C-n>:bfirst!<cr>
tnoremap ]B <C-\><C-n>:blast!<cr>

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

" make escape work inside terminal
tnoremap <Esc> <C-\><C-n>
" }}}

"  AirLine {{{
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
"  }}}

" Emmet {{{
let g:user_emmet_leader_key=','
let g:user_emmet_install_global = 0

let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}
" }}}

" UltiSnips {{{
let g:UltiSnipsSnippetDirectories = ['~/.UltiSnips']
let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
" }}}

" vimtex {{{
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_fold_enabled = 1
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
        autocmd BufWritePost init.vim source %
    augroup end

    " augroup completion
    "     au!
    "     autocmd VimEnter * COQnow
    " augroup end
endif
" }}}

" vim-coverage stuff {{{
call glaive#Install()
Glaive coverage uncovered_text='--' covered_text='++' partial_text='~~'
" }}}

" live markdown preview {{{
let g:mkdp_auto_start = 1
" let g:mkdp_browser = '/home/yog/bin/fnewwin'
let g:mkdp_browser = 'qutebrowser'
" }}}

" lua config
lua require("init")
