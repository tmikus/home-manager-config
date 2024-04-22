return {
  "nvim-lua/plenary.nvim",
  "tpope/vim-sensible",
  "tpope/vim-sleuth",
  "tpope/vim-surround",
  "andymass/vim-matchup",
  -- Opts are needed or the setup won't be called
  { "windwp/nvim-autopairs", opts = {} },
  "yuttie/comfortable-motion.vim",
  "editorconfig/editorconfig-vim",
  "mattn/emmet-vim",
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end
  },
}
