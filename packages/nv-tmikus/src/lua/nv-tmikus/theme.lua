local theme_config = require "nv-tmikus.configs.theme"
local theme_name = theme_config.theme

vim.cmd("colorscheme " .. theme_name)

require("colorizer").setup()
require("hlargs").setup()
