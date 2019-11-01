if has('nvim')
    nnoremap <F5> :w<CR>:vs \| te cargo run<CR>i
    inoremap <F5> <Esc>:w<CR>:vs \| te cargo run<CR>i
else
    nnoremap <F5> :w<CR>:vert bo term cargo run<CR>
    inoremap <F5> <Esc>:w<CR>:vert bo term cargo run<CR>
endif
