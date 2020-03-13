if has('nvim')
    inoremap <F5> <esc>:w<cr>:vs \| te bash %<cr>i
    nnoremap <F5> :w<cr>:vs \| te bash %<cr>i
else
    inoremap <F5> <esc>:w<cr>:!chmod +x %<cr>:vert bo term bash %<cr>
    nnoremap <F5> :w<cr>:!chmod +x %<cr>:vert bo term bash %<cr>
endif

let b:comment_leader = "#"

