USE_COQ =true

require "plugins"
require "lsp"

if USE_COQ then
    require "coq_completion"
else
    require "completion"
end

require "autopairs"
require "treesitter"
require "snippets"
require "debugger"
require "telescope_config"

require('orgmode').setup_ts_grammar()
require('orgmode').setup()

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = false
})
