local use = require('packer').use
require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'
    use 'nvim-treesitter/nvim-treesitter'
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'sidlatau/neotest-dart'
    use 'nvim-treesitter/nvim-treesitter-context'
    use {
      "nvim-neotest/neotest",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        "mfussenegger/nvim-dap"
      }
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'}, {'BurntSushi/ripgrep'} }
    }
end)
