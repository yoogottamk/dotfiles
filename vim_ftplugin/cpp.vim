" load template
nnoremap <leader>t ggdG:0r ~/.vim/skeleton/skel.cpp<CR>gg/main<CR>3j:noh<CR>o

" <F3> to split open a file which will be used for input
nnoremap <F3> :w<CR>:sp inp<CR>
inoremap <F3> <esc>:w<CR>:sp inp<CR>

" <F5> to build and run current file, with the input file [if exists]
" <F9> to build run and use codeforces sample test cases given for current
" question [deduced from name of file]
if has('nvim')
    nnoremap <F5> :w<CR>:vs \| te run %:p %:p:h/inp<CR>i
    inoremap <F5> <esc>:w<CR>:vs \| te run %:p %:p:h/inp<CR>i

    nnoremap <F9> :w<CR>:vs \| te cf % %:p<CR>i
    inoremap <F9> <Esc>:w<CR>:vs \| te cf % %:p<CR>i
else
    nnoremap <F5> :w<CR>:vert bo term run %:p %:p:h/inp<CR>
    inoremap <F5> <esc>:w<CR>:vert bo term run %:p %:p:h/inp<CR>

    nnoremap <F9> :w<CR>:vert bo term cf % %:p<CR>
    inoremap <F9> <Esc>:w<CR>:vert bo term cf % %:p<CR>
endif

let b:ale_linters=['gcc', 'clang']

let b:comment_leader = "//"

