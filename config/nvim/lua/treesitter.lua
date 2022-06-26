require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "bash", "bibtex", "c", "cmake", "comment", "cpp", "css", "dockerfile",
        "dot", "fish", "gdscript", "go", "godot_resource", "gomod", "gowork",
        "hjson", "html", "http", "java", "javascript", "jsdoc", "json", "json5",
        "jsonc", "julia", "kotlin", "latex", "llvm", "lua", "make", "markdown",
        "ninja", "nix", "perl", "php", "python", "rasi", "regex", "ruby",
        "rust", "scss", "toml", "tsx", "typescript", "vim", "yaml"
    },
    highlight = {
        enable = true,
        disable = {'org'},
        additional_vim_regex_highlighting = {'org'}
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm"
        }
    },
    indent = {enable = false}
}

require'treesitter-context'.setup {
    enable = true,
    throttle = true,
    max_lines = 0,
    patterns = {
        default = {
            'class', 'function', 'method', 'for', 'while', 'if', 'switch',
            'case'
        },
        python = {'with'}
    }
}
