local conditions = require "nv-tmikus.configs.lualine.conditions"
local colors = require "nv-tmikus.configs.lualine.colors"
local icons = require "nv-tmikus.configs.lualine.icons"

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local branch = icons.git.Branch

branch = "%#SLGitIcon#" .. icons.git.Branch .. "%*" .. "%#SLBranchName#"

return {
  mode = {
    function()
      return " " .. icons.ui.Target .. " "
    end,
    padding = { left = 0, right = 0 },
    color = {},
    cond = nil,
  },
  branch = {
    "b:gitsigns_head",
    icon = branch,
    color = { gui = "bold" },
  },
  filename = {
    "filename",
    color = {},
    cond = nil,
  },
  diff = {
    "diff",
    source = diff_source,
    symbols = {
      added = icons.git.LineAdded .. " ",
      modified = icons.git.LineModified .. " ",
      removed = icons.git.LineRemoved .. " ",
    },
    padding = { left = 2, right = 1 },
    diff_color = {
      added = { fg = colors.green },
      modified = { fg = colors.yellow },
      removed = { fg = colors.red },
    },
    cond = nil,
  },
  python_env = {
    function()
      local utils = require "nv-tmikus.configs.lualine.utils"
      if vim.bo.filetype == "python" then
        local venv = os.getenv "CONDA_DEFAULT_ENV" or os.getenv "VIRTUAL_ENV"
        if venv then
          local icons = require "nvim-web-devicons"
          local py_icon, _ = icons.get_icon ".py"
          return string.format(" " .. py_icon .. " (%s)", utils.env_cleanup(venv))
        end
      end
      return ""
    end,
    color = { fg = colors.green },
    cond = conditions.hide_in_width,
  },
  diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = {
      error = icons.diagnostics.BoldError .. " ",
      warn = icons.diagnostics.BoldWarning .. " ",
      info = icons.diagnostics.BoldInformation .. " ",
      hint = icons.diagnostics.BoldHint .. " ",
    },
    -- cond = conditions.hide_in_width,
  },
  treesitter = {
    function()
      return icons.ui.Tree
    end,
    color = function()
      local buf = vim.api.nvim_get_current_buf()
      local ts = vim.treesitter.highlighter.active[buf]
      return { fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red }
    end,
    cond = conditions.hide_in_width,
  },
  progress = {
    "progress",
    fmt = function()
      return "%P/%L"
    end,
    color = {},
  },

  spaces = {
    function()
      local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
      return icons.ui.Tab .. " " .. shiftwidth
    end,
    padding = 1,
  },
  encoding = {
    "o:encoding",
    fmt = string.upper,
    color = {},
    cond = conditions.hide_in_width,
  },
  filetype = { "filetype", cond = nil, padding = { left = 1, right = 1 } },
  scrollbar = {
    function()
      local current_line = vim.fn.line "."
      local total_lines = vim.fn.line "$"
      local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
      local line_ratio = current_line / total_lines
      local index = math.ceil(line_ratio * #chars)
      return chars[index]
    end,
    padding = { left = 0, right = 0 },
    color = "SLProgress",
    cond = nil,
  },
}

