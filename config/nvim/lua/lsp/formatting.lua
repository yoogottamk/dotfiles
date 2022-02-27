local null_ls = require("null-ls")

local format_on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
        vim.cmd([[
        augroup Format
            autocmd! * <buffer>
            autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync(nil, 3000)
        augroup END
        ]])
    end
end

null_ls.setup({
    on_attach = format_on_attach,
    sources = {
        null_ls.builtins.formatting.isort.with({
            cwd = function(params)
                return require("lspconfig")["pyright"].get_root_dir(
                           params.bufname)
            end
        }), null_ls.builtins.formatting.black.with({
            cwd = function(params)
                return require("lspconfig")["pyright"].get_root_dir(
                           params.bufname)
            end
        }), null_ls.builtins.formatting.lua_format,
        null_ls.builtins.formatting.djhtml,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.hover.dictionary
    }
})
