local function local_tabs_mapping(tab)
    return "<M-" .. tab .. ">"
end

-- Adding mappings to bufferline
local tab = 0
repeat
    vim.cmd('nnoremap <silent>' .. local_tabs_mapping(tab) .. ' <cmd>lua require("bufferline").go_to(' .. tab .. ')<cr>')
    tab = tab + 1
until tab == 20

require("bufferline").setup {
    highlights = {
        buffer_selected = {
            italic = false,
        },
    },
    options = {
        show_close_icon = false,
        offsets = {
            {
                filetype = "NvimTree",
                text = " Explorer",
                highlight = "NvimTreeNormal",
                text_align = "left",
            },
        },
    },
}
