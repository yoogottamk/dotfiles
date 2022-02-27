vim.cmd [[let g:coq_settings = { 'display.pum.fast_close': v:false, 'auto_start': 'shut-up' }]]

require("coq")

vim.cmd [[
    augroup completion
        au!
        autocmd VimEnter * COQnow -s
    augroup end
]]
