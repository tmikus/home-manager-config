local theme_config = require "nv-tmikus.configs.theme"
local theme_name = theme_config.theme

-- require("nv-tmikus.themes." .. theme_name)

vim.cmd("colorscheme " .. theme_name)
