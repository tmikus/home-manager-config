return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
  	"williamboman/mason.nvim",
    build = ":MasonInstallAll",
    opts = {
  		ensure_installed = {
        "css-lsp" ,
        "gopls",
  			"html-lsp",
  			"lua-language-server",
        "prettier",
        "python-lsp-server",
        "rust-analyzer",
        "stylua",
  		},
  	},
  },
  {
  	"nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
          require "ts_context_commentstring".setup {}
          vim.g.skip_ts_context_commentstring_module = true
        end,
      },
    },
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
       "html", "css"
  		},
  	},
  },
  "nvim-lua/plenary.nvim",
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "../file-finder"
    end
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = function()
      return vim.fn.executable "make" == 1
    end
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },
  "stevearc/dressing.nvim",
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {},
  },
  {
    "folke/zen-mode.nvim",
    config = function()
      require "../zen-mode-options"
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "v4.*",
  },
  "tpope/vim-sensible",
  "tpope/vim-surround",
  { "windwp/nvim-autopairs", opts = {} },
  "yuttie/comfortable-motion.vim",
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = require("../noice-options"),
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  }
}
