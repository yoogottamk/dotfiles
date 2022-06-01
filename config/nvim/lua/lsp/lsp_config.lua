local nvim_lsp = require("lspconfig")

local get_on_attach = function(disable_formatting)
    return function(client, bufnr)
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, "n", ...)
        end

        local function buf_set_option(...)
            vim.api.nvim_buf_set_option(bufnr, ...)
        end

        -- use lsp for <c-x><c-o>
        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

        local opts = {noremap = true, silent = true}

        buf_set_keymap("gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
        buf_set_keymap("gd",
                       "<cmd>lua require'telescope.builtin'.lsp_definitions()<cr>",
                       opts)
        buf_set_keymap("gi",
                       "<cmd>lua require'telescope.builtin'.lsp_implementations()<cr>",
                       opts)
        buf_set_keymap("<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
        buf_set_keymap("gr",
                       "<cmd>lua require'telescope.builtin'.lsp_references()<cr>",
                       opts)
        buf_set_keymap("M", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
        buf_set_keymap("[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
        buf_set_keymap("]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
        buf_set_keymap("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>",
                       opts)

        if disable_formatting then
            client.server_capabilities.document_formatting = false
            client.server_capabilities.documentFormattingProvider = false
        end

        vim.api.nvim_create_autocmd("CursorHold", {
            buffer = bufnr,
            callback = function()
                local diag_opts = {
                    focusable = false,
                    close_events = {
                        "BufLeave", "CursorMoved", "InsertEnter", "FocusLost"
                    },
                    border = 'rounded',
                    source = 'always',
                    prefix = ' ',
                    scope = 'cursor'
                }
                vim.diagnostic.open_float(nil, diag_opts)
            end
        })

        Format_on_attach(client)
    end
end

-- ui
vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = {
    {"🭽", "FloatBorder"}, {"▔", "FloatBorder"}, {"🭾", "FloatBorder"},
    {"▕", "FloatBorder"}, {"🭿", "FloatBorder"}, {"▁", "FloatBorder"},
    {"🭼", "FloatBorder"}, {"▏", "FloatBorder"}
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- enable snippets
local basic_capabilities = vim.lsp.protocol.make_client_capabilities()
local cap = require("cmp_nvim_lsp").update_capabilities(basic_capabilities)
cap.textDocument.completion.completionItem.snippetSupport = true

-- servers with default config
local default_config_servers = {
    "pyright", "bashls", "clangd", "dockerls", "gopls", "denols", "tsserver",
    "texlab", "html", "cssls"
}
for _, lsp in pairs(default_config_servers) do
    nvim_lsp[lsp].setup {on_attach = get_on_attach(), capabilities = cap}
end

-- julia
nvim_lsp.julials.setup {
    on_new_config = function(new_config, new_root_dir)
        local server_path = "/home/yog/.julia/packages/LanguageServer/jiDTR/src"
        local cmd = {
            "julia", "--project=" .. server_path, "--startup-file=no",
            "--history-file=no", "-e", [[
            using Pkg;
            Pkg.instantiate()
            using LanguageServer; using SymbolServer;
            depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
            project_path = dirname(something(Base.current_project(pwd()), Base.load_path_expand(LOAD_PATH[2])))
            # Make sure that we only load packages from this environment specifically.
            @info "Running language server" env=Base.load_path()[1] pwd() project_path depot_path
            server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path);
            server.runlinter = true;
            run(server);
        ]]
        };
        new_config.cmd = cmd
    end,
    on_attach = get_on_attach(),
    capabilities = cap
}

-- yaml
local cfg = require("yaml-companion").setup({
    lspconfig = {on_attach = get_on_attach(), capabilities = cap}
})
nvim_lsp.yamlls.setup(cfg)

-- lua
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup {
    on_attach = get_on_attach(true),
    cmd = {
        "/usr/bin/lua-language-server", "-E",
        "/usr/share/lua-language-server/main.lua"
    },
    settings = {
        Lua = {
            runtime = {version = "LuaJIT", path = runtime_path},
            diagnostics = {globals = {"vim"}},
            workspace = {library = vim.api.nvim_get_runtime_file("", true)},
            telemetry = {enable = false}
        }
    },
    capabilities = cap
}

-- dart/flutter
require("flutter-tools").setup {
    lsp = {
        color = {enabled = true, virtual_text = true, virtual_text_str = "■"},
        on_attach = get_on_attach(true),
        capabilities = cap
    }
}

-- rust
require("rust-tools").setup {
    server = {on_attach = get_on_attach(), capabilities = cap},
    dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(
            "/usr/bin/codelldb", "/usr/lib/codelldb/adapter/libcodelldb.so")
    }
}
