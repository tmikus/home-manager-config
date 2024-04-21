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
      { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
      "folke/neodev.nvim",
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
  },
  "maxmellon/vim-jsx-pretty",
  "jparise/vim-graphql",
}
