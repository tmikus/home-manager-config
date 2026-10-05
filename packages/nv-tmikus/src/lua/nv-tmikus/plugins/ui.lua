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
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
          require "ts_context_commentstring".setup {}
          vim.g.skip_ts_context_commentstring_module = true
        end,
      },
    },
    config = function()
      local ts = require "nvim-treesitter"
      local opts = require "nv-tmikus.configs.treesitter"

      ts.install(opts.ensure_installed)

      local available = {}
      if opts.auto_install then
        for _, lang in ipairs(ts.get_available()) do
          available[lang] = true
        end
      end

      local function attach(buf, lang)
        if not pcall(vim.treesitter.start, buf, lang) then
          return
        end
        if not vim.tbl_contains(opts.indent_disable, vim.bo[buf].filetype) then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("nv-tmikus-treesitter", { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang then
            return
          end
          if vim.treesitter.language.add(lang) then
            attach(args.buf, lang)
          elseif available[lang] then
            ts.install(lang):await(vim.schedule_wrap(function()
              if vim.api.nvim_buf_is_valid(args.buf) then
                attach(args.buf, lang)
              end
            end))
          end
        end,
      })

      -- Text objects
      local textobjects = opts.textobjects
      require("nvim-treesitter-textobjects").setup {
        select = { lookahead = textobjects.select.lookahead },
        move = { set_jumps = textobjects.move.set_jumps },
      }

      local select = require "nvim-treesitter-textobjects.select"
      for key, query in pairs(textobjects.select.keymaps) do
        vim.keymap.set({ "x", "o" }, key, function()
          select.select_textobject(query, "textobjects")
        end)
      end

      local move = require "nvim-treesitter-textobjects.move"
      for _, method in ipairs({ "goto_next_start", "goto_next_end", "goto_previous_start", "goto_previous_end" }) do
        for key, query in pairs(textobjects.move[method]) do
          vim.keymap.set({ "n", "x", "o" }, key, function()
            move[method](query, "textobjects")
          end)
        end
      end

      local swap = require "nvim-treesitter-textobjects.swap"
      for _, method in ipairs({ "swap_next", "swap_previous" }) do
        for key, query in pairs(textobjects.swap[method]) do
          vim.keymap.set("n", key, function()
            swap[method](query)
          end)
        end
      end
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
