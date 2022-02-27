local nvim_lsp = require("lspconfig")

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

local get_on_attach = function(disable_formatting)
    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    return function(client, bufnr)
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, "n", ...)
        end
        local function buf_set_option(...)
            vim.api.nvim_buf_set_option(bufnr, ...)
        end

        -- Enable completion triggered by <c-x><c-o>
        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        local opts = {noremap = true, silent = true}

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        buf_set_keymap("gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
        buf_set_keymap("gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
        buf_set_keymap("gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
        buf_set_keymap("<leader>r", ":Lspsaga rename<cr>", opts)
        buf_set_keymap("gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
        buf_set_keymap("M", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
        buf_set_keymap("[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
        buf_set_keymap("]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
        buf_set_keymap("<leader>ca", ":Lspsaga code_action<cr>", opts)

        if disable_formatting then
            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false
        end

        format_on_attach(client)
    end
end

-- enable snippets
local basic_capabilities = vim.lsp.protocol.make_client_capabilities()
local cap
if USE_COQ then
    cap = require("coq").lsp_ensure_capabilities(basic_capabilities)
else
    cap = require("cmp_nvim_lsp").update_capabilities(basic_capabilities)
end
cap.textDocument.completion.completionItem.snippetSupport = true

-- servers with default config
local default_config_servers = {
    "pyright", "bashls", "clangd", "dockerls", "gopls", "rust_analyzer",
    "denols", "tsserver", "texlab", "svelte", "html", "cssls"
}
for _, lsp in pairs(default_config_servers) do
    nvim_lsp[lsp].setup {
        on_attach = get_on_attach(),
        flags = {debounce_text_changes = 150},
        capabilities = cap
    }
end

-- dart
nvim_lsp.dartls.setup {
    cmd = {
        "dart",
        "/opt/flutter/bin/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot",
        "--lsp"
    },
    on_attach = get_on_attach(),
    flags = {debounce_text_changes = 150},
    capabilities = cap
}

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
    flags = {debounce_text_changes = 150},
    capabilities = cap
}

-- yaml
nvim_lsp.yamlls.setup {
    on_attach = get_on_attach(),
    flags = {debounce_text_changes = 150},
    settings = {
        yaml = {
            schemas = {
                ["kubernetes"] = {"*kube*", "spec.yaml", "kube.yaml"},
                ["https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json"] = {
                    "**/docker-compose.yaml", "**/docker-compose.yml"
                },
                ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = {
                    "spec.yaml", "argo.yaml"
                }
            }
        }
    },
    capabilities = cap
}

-- lua
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup {
    on_attach = get_on_attach(true),
    flags = {debounce_text_changes = 150},
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
