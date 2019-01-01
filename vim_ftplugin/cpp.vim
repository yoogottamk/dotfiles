nnoremap <F5> :w<CR>:vert bo term br %<CR>
inoremap <F5> <Esc>:w<CR>:vert bo term br %<CR>

nnoremap <leader>t ggdG:0r ~/.vim/skeleton/skel.cpp<CR>15jo

nnoremap <F9> :w<CR>:vert bo term cf % %:p<CR>
inoremap <F9> <Esc>:w<CR>:vert bo term cf % %:p<CR>

let b:ale_linters=['gcc', 'clang']
