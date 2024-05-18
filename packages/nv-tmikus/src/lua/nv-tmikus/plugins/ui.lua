return {
  {
    "akinsho/bufferline.nvim",
    version = "v4.*",
  },
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup(require "nv-tmikus.configs.nvim-tree")
    end
  },
  "kyazdani42/nvim-web-devicons",
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup(require "nv-tmikus.configs.telescope")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = function()
      return vim.fn.executable "make" == 1
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("nv-tmikus.configs.lualine").setup()
    end
    -- opts = require "nv-tmikus.configs.lualine",
  },
  "folke/which-key.nvim",
  {
    "glepnir/dashboard-nvim",
    config = function()
      require("dashboard").setup(require "nv-tmikus.configs.dashboard")
    end
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
    config = function()
      pcall(require("nvim-treesitter.install").update { with_sync = false })
      require("nvim-treesitter.configs").setup(require "nv-tmikus.configs.treesitter")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup(require "nv-tmikus.configs.indent-blankline")
    end
  },
  "stevearc/dressing.nvim",
  "moll/vim-bbye",
  "norcalli/nvim-colorizer.lua",
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = require "nv-tmikus.configs.noice",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  }, 
  -- Fancy in-terminal scrollbar
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup(require "nv-tmikus.configs.scrollbar")
    end
  },
  -- Highlight arguments
  {
    "m-demare/hlargs.nvim",
    opts = {},
    event = "VeryLazy",
    dependencies = {
      -- Floading window support
      "ray-x/guihua.lua",
    },
  },
  -- Color highlighter for Neovim
  {
    "NvChad/nvim-colorizer.lua",
    opts = {},
    event = "VeryLazy",
  },
  -- Rainbow delimiters
  {
    "HiPhish/rainbow-delimiters.nvim",
    -- opts = require "nv-tmikus.configs.delimiters",
    config = function()
      require("rainbow-delimiters.setup").setup(require "nv-tmikus.configs.delimiters")
    end
  },
}
