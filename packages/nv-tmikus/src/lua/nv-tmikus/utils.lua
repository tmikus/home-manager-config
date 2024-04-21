local M = {}

M.get_file_name = function()
    if vim.bo.filetype == "NvimTree" then
        return "  Explorer"
    else
        return " " .. vim.fn.expand "%:t"
    end
end
    
M.load_theme_when_needed = function(theme_name, theme_definition)
    if require("nv-tmikus.configs.theme").theme ~= theme_name then
        return {}
    end
    local theme = type(theme_definition) == "string" and { theme_definition } or theme_definition
    theme.priority = 1000
    return theme
end

return M