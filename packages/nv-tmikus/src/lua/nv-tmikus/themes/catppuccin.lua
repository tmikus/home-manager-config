local theme_config = require "nv-tmikus.configs.theme"

return {
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
