nmap <F5> :w<CR>:vert bo term br %<CR>
imap <F5> <Esc>:w<CR>:vert bo term br %<CR>

map <leader>c ggdG:0r ~/.vim/skeleton/skel.cpp<CR>6jO

let b:ale_linters=['gcc', 'clang']
