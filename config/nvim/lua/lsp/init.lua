require("lsp.lsp_config")
require("lsp.formatting")

-- signature help
require("lsp_signature").setup({
    bind = true,
    hint_enable = false,
    hint_prefix = "",
})