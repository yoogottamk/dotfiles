nnoremap <silent> <leader>/ :call <SID>ToggleComment()<cr>
vnoremap <silent> <leader>/ :call <SID>ToggleComment()<cr>

fu! s:ToggleComment()
    let l:line = getline('.')

    if l:line =~ '\s\?' . b:comment_leader
        " line is already commented
        let l:comment_index = stridx(l:line, b:comment_leader)
        let l:indentation = l:line[0:l:comment_index - 1]
        let l:without_comment = l:line[l:comment_index + len(b:comment_leader):]
        call setline('.', l:indentation . trim(l:without_comment))
    else
        " have to comment this line
        let l:indentation = (indent('.') > 0 ? l:line[0:indent('.') - 1] : '')
        let l:line_contents = l:line[indent('.'):]
        call setline('.', l:indentation . b:comment_leader . repeat(" ", len(b:comment_leader)) . l:line_contents)
    endif
endfunction

