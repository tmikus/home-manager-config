return {
  {
    "akinsho/bufferline.nvim",
    version = "v4.*",
  },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup(require "nv-tmikus.configs.nvim-tree")
    end
  },
  "nvim-tree/nvim-web-devicons",
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
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nv-tmikus.configs.lualine").setup()
    end
  },
  {
    "folke/which-key.nvim",
    dependencies = {
      "echasnovski/mini.icons",
    },
  },
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
      require("nvim-treesitter.configs").setup(require "nv-tmikus.configs.treesitter")
      -- Defer treesitter updates to after startup for better load time
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          vim.defer_fn(function()
            pcall(require("nvim-treesitter.install").update, { with_sync = false })
          end, 100)
        end,
        once = true,
      })
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
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
  },
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
  -- Rainbow delimiters
  {
    "HiPhish/rainbow-delimiters.nvim",
    -- opts = require "nv-tmikus.configs.delimiters",
    config = function()
      require("rainbow-delimiters.setup").setup(require "nv-tmikus.configs.delimiters")
    end
  },
  -- Clipboard manager
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      {"nvim-telescope/telescope.nvim"},
      {"kkharji/sqlite.lua"},
    },
    opts = {
      enable_persistent_history = true,
      initial_mode = "normal",
    },
    config = true,
  },
  -- Session manager
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      auto_restore_last_session = true,
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
    },
    config = true,
  },
}
