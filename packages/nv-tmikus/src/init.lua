lvim = {
    builtin = {
        lualine = require "nv-tmikus.configs.lualine"
    }
}

vim.g.mapleader = " "

require "nv-tmikus.lazy"
require "nv-tmikus.lsp"
require "nv-tmikus.normalize"
require "nv-tmikus.theme"
require "nv-tmikus.shortcuts"
require "nv-tmikus.bufferline"
