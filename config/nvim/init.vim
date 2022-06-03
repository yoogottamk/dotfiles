" {{{ internal vim packages
packadd matchit
packadd packer.nvim
" }}}

" lua config
lua require("init")

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

" theme
set t_Co=256
set background=dark
colo srcery
let g:srcery_italic = 1
let g:srcery_transparent_background = 1
set termguicolors
hi Normal guibg=NONE ctermbg=NONE
hi Comment gui=italic

" statusline already shows this
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

set completeopt=menu,menuone,noselect,noinsert,preview
set sessionoptions+=winpos,terminal,folds
set updatetime=250

set signcolumn=number
" }}}

"  maps {{{
" for spellings
nnoremap <F7> :setlocal spell! spelllang=en<cr>
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
nnoremap <leader>q :Bdelete<cr>
nnoremap <leader>x :x<cr>
nnoremap <leader>w :w<cr>

" Useful
nnoremap H ^
nnoremap L $
nnoremap <leader><space> :noh<cr>

" telescope
nnoremap <F2> <cmd>Telescope buffers<cr>
nnoremap <leader>j <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>k <cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>
nnoremap <leader>l <cmd>Telescope find_files<cr>

" edit init.vim
nnoremap <leader>ev :vs ~/.config/nvim/init.vim<cr>

" make commenting easier
nnoremap <leader>/ :Commentary<cr>
vnoremap <leader>/ :Commentary<cr>

" cd to dir containing this file
nnoremap <leader>cd :cd %:p:h<cr>

" move (selected) line(s) up or down
nnoremap <silent> + :m .+1<cr>==
nnoremap <silent> - :m .-2<cr>==
vnoremap <silent> + :m '>+1<cr>gv=gv
vnoremap <silent> - :m '<-2<cr>gv=gv

" for buffer navigation
nnoremap ]b :bn!<cr>
nnoremap [b :bp!<cr>
tnoremap ]b <C-\><C-n>:bn!<cr>
tnoremap [b <C-\><C-n>:bp!<cr>

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

" debugging
nnoremap <leader>b :lua require'dap'.toggle_breakpoint()<cr>
nnoremap <leader>c :lua require'dap'.continue()<cr>
nnoremap <leader>n :lua require'dap'.step_over()<cr>
nnoremap <leader>s :lua require'dap'.step_into()<cr>
" }}}

" Emmet {{{
let g:user_emmet_leader_key=','
let g:user_emmet_install_global = 0

let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}
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

    augroup orgmode
        au!
        autocmd BufWritePost *.org call jobstart(['emacs', '-nw', '--batch', '--eval', '(setq org-confirm-babel-evaluate nil)', '--visit=' . expand('%'), '-f', 'org-latex-export-to-pdf'])
        autocmd CursorHold *.org if &modified | w | call jobstart(['emacs', '-nw', '--batch', '--eval', '(setq org-confirm-babel-evaluate nil)', '--visit=' . expand('%'), '-f', 'org-latex-export-to-pdf']) | endif
        autocmd CursorHoldI *.org if &modified | w | call jobstart(['emacs', '-nw', '--batch', '--eval', '(setq org-confirm-babel-evaluate nil)', '--visit=' . expand('%'), '-f' ,'org-latex-export-to-pdf']) | endif
    augroup end

    augroup jsx
        au!
        autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
    augroup end

    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
endif
" }}}

" live markdown preview {{{
" let g:mkdp_browser = 'qutebrowser'
" }}}

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
