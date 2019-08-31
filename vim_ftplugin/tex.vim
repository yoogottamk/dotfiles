let localleader='\'

nnoremap <F5> :VimtexCompile<cr>
inoremap <leader>b \textbf{}<esc>i
inoremap <leader>i \textit{}<esc>i
inoremap <leader>t \texttt{}<esc>i
inoremap <leader>u \underline{}<esc>i

let b:comment_leader = "%"

setl spell spelllang=en
setl conceallevel=2
