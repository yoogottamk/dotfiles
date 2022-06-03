local packer = require("packer")

return packer.startup(function(use)
    -- lsp, treesitter, other ide-like features
    use 'neovim/nvim-lspconfig'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

    use 'jose-elias-alvarez/null-ls.nvim'

    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'

    -- completion and snippets
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'onsails/lspkind-nvim'

    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'rafamadriz/friendly-snippets'

    use {
        "someone-stole-my-name/yaml-companion.nvim",
        requires = {
            {"neovim/nvim-lspconfig"}, {"nvim-lua/plenary.nvim"},
            {"nvim-telescope/telescope.nvim"}
        }
    }

    -- themes
    use {'srcery-colors/srcery-vim', as = 'srcery'}

    -- utility
    use 'lewis6991/nvim-treesitter-context'
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use {
        'akinsho/bufferline.nvim',
        tag = "*",
        requires = 'kyazdani42/nvim-web-devicons'
    }
    use 'windwp/nvim-autopairs'
    use 'tpope/vim-commentary'
    use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use 'stevearc/dressing.nvim'
    use {
        'tzachar/cmp-fuzzy-buffer',
        requires = {'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim'}
    }
    use 'rmagatti/auto-session'

    use 'moll/vim-bbye'

    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'tpope/vim-fugitive'

    -- language specific
    -- -- markdown
    use {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = {"markdown"} end,
        ft = {"markdown"}
    }

    -- -- latex
    use {'lervag/vimtex', ft = {'tex'}}

    -- -- python
    use {'tmhedberg/SimpylFold', ft = {'python'}}

    -- -- java
    -- use {'mfussenegger/nvim-jdtls'}

    -- -- dart / flutter
    use {'dart-lang/dart-vim-plugin', ft = {'dart'}}
    use {'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'}

    -- -- js and family
    -- use {
    --     'peitalin/vim-jsx-typescript',
    --     requires = {'leafgarland/typescript-vim'},
    --     ft = {'typescriptreact'}
    -- }
    -- use {'MaxMEllon/vim-jsx-pretty', ft = {'typescriptreact'}}
    use 'mattn/emmet-vim'

    -- -- rust
    use 'simrat39/rust-tools.nvim'

end)
