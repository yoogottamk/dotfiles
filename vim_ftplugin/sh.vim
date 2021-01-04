" <F3> to split open a file which will be used for input
nnoremap <F3> :w<CR>:sp inp<CR>
inoremap <F3> <esc>:w<CR>:sp inp<CR>

" <F5> to build and run current file, with the input file [if exists]
if has('nvim')
    nnoremap <F5> :w<CR>:vs \| te run %:p %:p:h/inp<CR>i
    inoremap <F5> <esc>:w<CR>:vs \| te run %:p %:p:h/inp<CR>i
else
    nnoremap <F5> :w<CR>:vert bo term run %:p %:p:h/inp<CR>
    inoremap <F5> <esc>:w<CR>:vert bo term run %:p %:p:h/inp<CR>
endif

let b:comment_leader = "#"
