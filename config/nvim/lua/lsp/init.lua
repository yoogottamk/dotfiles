Format_on_attach = function(client)
    if client.server_capabilities.documentFormattingProvider then
        vim.cmd([[
        augroup Format
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
        augroup END
        ]])
        -- autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync(nil, 3000); vim.cmd "silent noa write"
    end
end

require("lsp.lsp_config")
require("lsp.formatting")
