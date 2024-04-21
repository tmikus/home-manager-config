local theme_config = require "nv-tmikus.configs.theme"
local theme_name = theme_config.theme

if theme_name == "catppuccin" then
    require("catppuccin").setup {
        flavour = theme_config.catppuccin_flavour,
        transparent_background = false,
        term_colors = false,
        compile = {
          enabled = false,
          path = vim.fn.stdpath "cache" .. "/catppuccin",
        },
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        integrations = {},
        color_overrides = {},
        highlight_overrides = {
          all = function(colors)
            return {
              NormalFloat = { bg = colors.none },
            }
          end,
        },
    }
end

if theme_name == "material" then
    require('material').setup({

        contrast = {
            terminal = true, -- Enable contrast for the built-in terminal
            sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
            floating_windows = true, -- Enable contrast for floating windows
            cursor_line = true, -- Enable darker background for the cursor line
            lsp_virtual_text = true, -- Enable contrasted background for lsp virtual text
            non_current_windows = false, -- Enable contrasted background for non-current windows
            filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
        },

        styles = { -- Give comments style such as bold, italic, underline etc.
            comments = { --[[ italic = true ]] },
            strings = { --[[ bold = true ]] },
            keywords = { --[[ underline = true ]] },
            functions = { --[[ bold = true, undercurl = true ]] },
            variables = {},
            operators = {},
            types = {},
        },

        plugins = { -- Uncomment the plugins that you use to highlight them
            -- Available plugins:
            -- "coc"
            -- "dap",
            "dashboard",
            -- "eyeliner",
            -- "fidget",
            -- "flash",
            "gitsigns",
            -- "harpoon",
            -- "hop",
            -- "illuminate",
            "indent-blankline",
            -- "lspsaga",
            -- "mini",
            -- "neogit",
            -- "neotest",
            -- "neo-tree",
            -- "neorg",
            "noice",
            -- "nvim-cmp",
            -- "nvim-navic",
            "nvim-tree",
            -- "nvim-web-devicons",
            -- "rainbow-delimiters",
            -- "sneak",
            -- "telescope",
            -- "trouble",
            "which-key",
            "nvim-notify",
        },

        disable = {
            colored_cursor = false, -- Disable the colored cursor
            borders = false, -- Disable borders between verticaly split windows
            background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
            term_colors = false, -- Prevent the theme from setting terminal colors
            eob_lines = true -- Hide the end-of-buffer lines
        },

        high_visibility = {
            lighter = false, -- Enable higher contrast text for lighter style
            darker = false -- Enable higher contrast text for darker style
        },

        lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

        async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

        custom_colors = nil, -- If you want to override the default colors, set this to a function

        custom_highlights = {}, -- Overwrite highlights with your own
    })
end

vim.cmd("colorscheme " .. theme_name)
