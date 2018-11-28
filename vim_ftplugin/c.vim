if (&ft != 'c')
    finish
endif

map <leader>c ggdG:0r ~/.vim/skeleton/skel.c<CR>3jo<esc>O

nmap <F5> :w<CR>:vert bo term cbr %<CR>
imap <F5> <Esc>:w<CR>:vert bo term cbr %<CR>

nmap <F9> :w<CR>:vert bo term cf % %:p<CR>
imap <F9> <Esc>:w<CR>:vert bo term cf % %:p<CR>

let b:ale_linters=['gcc']
