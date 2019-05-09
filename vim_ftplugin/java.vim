nnoremap <F5> :w<CR>:vert bo term jr %<CR>
inoremap <F5> <Esc>:w<CR>:vert bo term jr %<CR>

iabbrev psvm public<Space>static<Space>void<Space>main(String<Space>args[])<Space>{<CR>}<Esc>ki<Tab><Tab>

iabbrev sol System.out.println();<Esc>hi
iabbrev sop System.out.print();<Esc>hi

let b:comment_leader = "//"

