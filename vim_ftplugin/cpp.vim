nmap <F5> :w<CR>:vert bo term br %<CR>
imap <F5> <Esc>:w<CR>:vert bo term br %<CR>

map <leader>c ggdG:0r ~/.vim/skeleton/skel.cpp<CR>11jo

nmap <F9> :w<CR>:vert bo term cf %<CR>
imap <F9> <Esc>:w<CR>:vert bo term cf %<CR>

let b:ale_linters=['gcc', 'clang']
