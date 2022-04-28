require "plugins"
require "lsp"
require "completion"
require "autopairs"
require "treesitter"
require "snippets"
require "debugger"
require "telescope_config"

require "bufferline_config"
require "statusline_config"

require('orgmode').setup_ts_grammar()
require('orgmode').setup()

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = false
})
