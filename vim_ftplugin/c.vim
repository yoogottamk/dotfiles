if (&ft != 'c')
    finish
endif

nmap <F5> :w<CR>:vert bo term cbr %<CR>
imap <F5> <Esc>:w<CR>:vert bo term cbr %<CR>

let b:ale_linters=['gcc']
