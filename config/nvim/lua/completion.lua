local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
               vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col,
                                                                          col)
                   :match("%s") == nil
end

local cmp = require 'cmp'
local compare = require 'cmp.config.compare'
local lspkind = require 'lspkind'
local luasnip = require 'luasnip'

cmp.setup({
    enabled = function()
        if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
            return false
        end
        -- disable completion in comments
        local context = require 'cmp.config.context'
        -- keep command mode completion enabled when cursor is in a comment
        if vim.api.nvim_get_mode().mode == 'c' then
            return true
        else
            return not context.in_treesitter_capture("comment") and
                       not context.in_syntax_group("Comment")
        end
    end,
    view = {entries = {name = 'custom', selection_order = 'near_cursor'}},
    formatting = {
        format = lspkind.cmp_format({with_text = false, maxwidth = 50})
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    snippet = {
        expand = function(args) require'luasnip'.lsp_expand(args.body) end
    },
    mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({select = true}),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, {'i', 's', 'c'}),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's', 'c'})
    },
    sources = cmp.config.sources({
        {name = 'nvim_lsp_signature_help'}, {name = 'nvim_lsp'},
        {name = 'luasnip'}
    }, {
        {
            name = 'fuzzy_buffer',
            option = {
                get_bufnrs = function()
                    local bufs = {}
                    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                        local buftype = vim.api.nvim_buf_get_option(buf,
                                                                    'buftype')
                        if buftype ~= 'nofile' and buftype ~= 'prompt' then
                            bufs[#bufs + 1] = buf
                        end
                    end
                    return bufs
                end
            }
        }
    }),
    experimental = {ghost_text = true},
    sorting = {
        priority_weight = 2,
        comparators = {
            require('cmp_fuzzy_buffer.compare'), compare.offset, compare.exact,
            compare.score, compare.recently_used, compare.kind,
            compare.sort_text, compare.length, compare.order
        }
    }
})

cmp.setup.cmdline('/', {sources = {{name = 'fuzzy_buffer'}}})

cmp.setup.cmdline(':', {
    sources = cmp.config.sources({{name = 'path'}, {name = 'cmdline'}})
})
