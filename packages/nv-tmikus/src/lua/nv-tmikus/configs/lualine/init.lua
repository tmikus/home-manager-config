local M = {}

-- Local config table instead of global lvim
M.config = {
  active = true,
  style = "lvim",
  options = {
    icons_enabled = nil,
    component_separators = nil,
    section_separators = nil,
    theme = nil,
    disabled_filetypes = { statusline = { "alpha" } },
    globalstatus = true,
  },
  sections = {
    lualine_a = nil,
    lualine_b = nil,
    lualine_c = nil,
    lualine_x = nil,
    lualine_y = nil,
    lualine_z = nil,
  },
  inactive_sections = {
    lualine_a = nil,
    lualine_b = nil,
    lualine_c = nil,
    lualine_x = nil,
    lualine_y = nil,
    lualine_z = nil,
  },
  tabline = nil,
  extensions = nil,
}

M.setup = function()
  if #vim.api.nvim_list_uis() == 0 then
    return
  end

  local status_ok, lualine = pcall(require, "lualine")
  if not status_ok then
    return
  end

  require("nv-tmikus.configs.lualine.styles").update(M.config)

  lualine.setup(M.config)
end

return M
