local utils = require "nv-tmikus.utils"

return {
    utils.load_theme_when_needed("astrotheme", {
        "AstroNvim/astrotheme",
        opts = require "nv-tmikus.themes.astrotheme",
    }),
    utils.load_theme_when_needed("catppuccin", {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = require "nv-tmikus.themes.catppuccin",
    }),
    utils.load_theme_when_needed("material", {
        "marko-cerovac/material.nvim",
        opts = require "nv-tmikus.themes.material",
    }),
}
