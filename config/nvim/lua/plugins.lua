local packer = require("packer")

return packer.startup(function(use)
    -- lsp, treesitter, other ide-like features
    use 'neovim/nvim-lspconfig'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

    use 'jose-elias-alvarez/null-ls.nvim'

    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'

    use {'tami5/lspsaga.nvim', branch = 'nvim6.0'}
    use 'ray-x/lsp_signature.nvim'

    -- completion and snippets
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'onsails/lspkind-nvim'

    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'rafamadriz/friendly-snippets'

    -- themes
    use 'vim-airline/vim-airline'
    use {'srcery-colors/srcery-vim', as = 'srcery'}

    -- utility
    use 'lewis6991/nvim-treesitter-context'
    use {
        'akinsho/bufferline.nvim',
        tag = "*",
        requires = 'kyazdani42/nvim-web-devicons'
    }
    use 'windwp/nvim-autopairs'
    use 'tpope/vim-commentary'
    use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use {
        'tzachar/cmp-fuzzy-buffer',
        requires = {'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim'}
    }
    use {
        'tzachar/cmp-fuzzy-path',
        requires = {'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim'}
    }
    use 'rmagatti/auto-session'
    use {
        'nvim-orgmode/orgmode',
        config = function() require('orgmode').setup {} end
    }

    use 'moll/vim-bbye'

    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'tpope/vim-fugitive'

    -- language specific
    -- -- markdown
    use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'}

    -- -- latex
    use {'lervag/vimtex', ft = {'tex'}}

    -- -- python
    use {'tmhedberg/SimpylFold', ft = {'python'}}

    -- -- java
    use {'mfussenegger/nvim-jdtls'}

    -- -- dart / flutter
    use {'dart-lang/dart-vim-plugin', ft = {'dart'}}
    use {'thosakwe/vim-flutter', ft = {'dart'}}

    -- -- js and family
    use {
        'peitalin/vim-jsx-typescript',
        requires = {'leafgarland/typescript-vim'},
        ft = {'typescriptreact'}
    }
    use {'MaxMEllon/vim-jsx-pretty', ft = {'typescriptreact'}}
    use {
        'mattn/emmet-vim',
        ft = {'html', 'css', 'php', 'javascript.jsx', 'typescriptreact'}
    }

end)
