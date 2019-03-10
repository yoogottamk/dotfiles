if (&ft != 'c')
    finish
endif

nnoremap <leader>t ggdG:0r ~/.vim/skeleton/skel.c<CR>5jo<esc>O

nnoremap <F5> :w<CR>:vert bo term cbr %<CR>
inoremap <F5> <Esc>:w<CR>:vert bo term cbr %<CR>

nnoremap <F9> :w<CR>:vert bo term cf % %:p<CR>
inoremap <F9> <Esc>:w<CR>:vert bo term cf % %:p<CR>

nnoremap <leader>c maI//  <esc>`a4l
nnoremap <leader>u ma^4x`a4h

let b:ale_linters=['gcc']

let b:comment_leader = "//"

