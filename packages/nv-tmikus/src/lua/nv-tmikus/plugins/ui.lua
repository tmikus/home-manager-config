return {
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup(require("nv-tmikus.configs.nvim-tree"))
    end
  },
  "kyazdani42/nvim-web-devicons",
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "nv-tmikus.configs.telescope"
    end,
  },
}
