return {
  -- Shows the GIT modifications in the code lines panel
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {},
  },
  -- Shows the git modified files in the nvtree
  -- {
  --   "tpope/vim-fugitive",
  --   opts = {},
  -- }
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    config = true,
  },
}
