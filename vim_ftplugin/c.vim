" reqd to fix conflicts between c and cpp files
if (&ft != 'c')
    finish
endif

" load template
nnoremap <leader>t ggdG:0r ~/.vim/skeleton/skel.c<CR>5jo<esc>O

" <F3> to split open a file which will be used for input
nnoremap <F3> :w<CR>:sp inp<CR>
inoremap <F3> <esc>:w<CR>:sp inp<CR>

" <F5> to build and run current file, with the input file [if exists]
nnoremap <F5> :w<CR>:vert bo term run %:p %:p:h/inp<CR>
inoremap <F5> <esc>:w<CR>:vert bo term run %:p %:p:h/inp<CR>

" <F9> to build run and use codeforces sample test cases given for current
" question [deduced from name of file]
nnoremap <F9> :w<CR>:vert bo term cf % %:p<CR>
inoremap <F9> <Esc>:w<CR>:vert bo term cf % %:p<CR>

let b:ale_linters=['gcc']

let b:comment_leader = "//"

