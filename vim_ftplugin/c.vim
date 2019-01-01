if (&ft != 'c')
    finish
endif

nnoremap <leader>t ggdG:0r ~/.vim/skeleton/skel.c<CR>3jo<esc>O

nnoremap <F5> :w<CR>:vert bo term cbr %<CR>
inoremap <F5> <Esc>:w<CR>:vert bo term cbr %<CR>

nnoremap <F9> :w<CR>:vert bo term cf % %:p<CR>
inoremap <F9> <Esc>:w<CR>:vert bo term cf % %:p<CR>

let b:ale_linters=['gcc']
