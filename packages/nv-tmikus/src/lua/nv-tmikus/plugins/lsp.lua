return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason.nvim",
        build = function()
          require("mason").setup(require("nv-tmikus.configs.mason"))
          vim.api.nvim_command(":MasonUpdate")
        end,
      },
      "williamboman/mason-lspconfig.nvim",
      -- opts are needed or the setup won't be called
      { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
      "folke/neodev.nvim",
    },
  },
  {
    "rshkarin/mason-nvim-lint",
    dependencies = {
      "mfussenegger/nvim-lint",
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      {
        "nvimtools/none-ls.nvim",
        dependencies = {
          "nvimtools/none-ls-extras.nvim",
        }
      }
    },
  },
  "maxmellon/vim-jsx-pretty",
  "jparise/vim-graphql",
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require "nv-tmikus.configs.nvim-cmp"
    end
  },
  -- Go Language Support
  "ray-x/go.nvim",
}
