local nvim_lsp = require("lspconfig")

local format_on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_command [[augroup Format]]
        vim.api.nvim_command [[autocmd! * <buffer>]]
        vim.api
            .nvim_command [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
        vim.api.nvim_command [[augroup END]]
    end
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = {noremap = true, silent = true}

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<cr>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    buf_set_keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)

    -- lspsaga better for these
    buf_set_keymap("n", "gh",
                   [[<cmd>lua require"lspsaga.provider".lsp_finder()<cr>]], opts)
    buf_set_keymap("n", "<leader>ca",
                   [[<cmd>lua require"lspsaga.codeaction".code_action()<cr>]],
                   opts)
    buf_set_keymap("n", "M",
                   [[<cmd>lua require"lspsaga.hover".render_hover_doc()<cr>]],
                   opts)
    buf_set_keymap("n", "[d",
                   [[<cmd>lua require"lspsaga.diagnostic".lsp_jump_diagnostic_prev()<cr>]],
                   opts)
    buf_set_keymap("n", "]d",
                   [[<cmd>lua require"lspsaga.diagnostic".lsp_jump_diagnostic_next()<cr>]],
                   opts)
    buf_set_keymap("n", "<C-f>",
                   [[<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<cr>]],
                   opts)
    buf_set_keymap("n", "<C-b>",
                   [[<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<cr>]],
                   opts)

    format_on_attach(client)
end

-- enable snippets
local cap = vim.lsp.protocol.make_client_capabilities()
cap.textDocument.completion.completionItem.snippetSupport = true

-- python
nvim_lsp.pyright.setup {
    on_attach = on_attach,
    flags = {debounce_text_changes = 150},
    capabilities = cap
}

-- bash
nvim_lsp.bashls.setup {
    on_attach = on_attach,
    flags = {debounce_text_changes = 150},
    capabilities = cap
}

-- clangd
nvim_lsp.clangd.setup {
    on_attach = on_attach,
    flags = {debounce_text_changes = 150},
    capabilities = cap
}

-- dart
nvim_lsp.dartls.setup {
    cmd = {
        "dart",
        "/opt/flutter/bin/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot",
        "--lsp"
    },
    on_attach = on_attach,
    flags = {debounce_text_changes = 150},
    capabilities = cap
}

-- dockerfile
nvim_lsp.dockerls.setup {
    on_attach = on_attach,
    flags = {debounce_text_changes = 150},
    capabilities = cap
}

-- go
nvim_lsp.gopls.setup {
    on_attach = on_attach,
    flags = {debounce_text_changes = 150},
    capabilities = cap
}

-- julia
nvim_lsp.julials.setup {
    on_new_config = function(new_config, new_root_dir)
        server_path = "/home/yog/.julia/packages/LanguageServer/jiDTR/src"
        cmd = {
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
    on_attach = on_attach,
    flags = {debounce_text_changes = 150},
    capabilities = cap
}

-- rust
nvim_lsp.rust_analyzer.setup {
    on_attach = on_attach,
    flags = {debounce_text_changes = 150},
    capabilities = cap
}

-- denols
nvim_lsp.denols.setup {
    on_attach = on_attach,
    flags = {debounce_text_changes = 150},
    capabilities = cap
}

-- latex
nvim_lsp.texlab.setup {
    on_attach = on_attach,
    flags = {debounce_text_changes = 150},
    capabilities = cap
}

-- yaml
nvim_lsp.yamlls.setup {
    on_attach = on_attach,
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
    on_attach = on_attach,
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

-- svelte
nvim_lsp.svelte.setup {
    on_attach = on_attach,
    flags = {debounce_text_changes = 150},
    capabilities = cap
}

-- html
nvim_lsp.html.setup {
    on_attach = on_attach,
    flags = {debounce_text_changes = 150},
    capabilities = cap
}

-- for formatting

vim.lsp.handlers["textDocument/formatting"] =
    function(err, _, result, _, bufnr)
        if err ~= nil or result == nil then return end
        if not vim.api.nvim_buf_get_option(bufnr, "modified") then
            local view = vim.fn.winsaveview()
            vim.lsp.util.apply_text_edits(result, bufnr)
            vim.fn.winrestview(view)
            if bufnr == vim.api.nvim_get_current_buf() then
                vim.api.nvim_command("noautocmd :update")
            end
        end
    end

nvim_lsp.efm.setup {
    init_options = {documentFormatting = true},
    on_attach = format_on_attach,
    filetypes = {"python", "sh", "lua"},
    settings = {
        rootMarkers = {".git", "venv"},
        languages = {
            python = {
                -- {formatCommand = "isort --quiet -", formatStdin = true},
                {formatCommand = "black --quiet -", formatStdin = true}
            },
            sh = {
                {
                    lintCommand = "shellcheck -f gcc -x",
                    lintStdin = true,
                    lintSource = "shellcheck",
                    lintFormats = {
                        "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m",
                        "%f:%l:%c: %tote: %m"
                    }
                }
            },
            lua = {{formatCommand = "lua-format -i", formatStdin = true}}
        }
    },
    capabilities = cap
}

-- using lspsaga since it looks better
require"lspsaga".init_lsp_saga()
-- show function signature when cursor idle in insert mode
vim.cmd [[autocmd CursorHoldI * silent! lua require("lspsaga.signaturehelp").signature_help()]]
