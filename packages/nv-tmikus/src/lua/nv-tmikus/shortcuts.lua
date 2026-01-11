local wk = require "which-key"
local telescope = require "telescope.builtin"
local neogit = require "neogit"
local gitsigns = require "gitsigns"

wk.add({
    {
        mode = "n",
        -- General
        { "<c-s>", "<cmd>w<cr>", desc = "Save changes", icon = "󰆓", nowait = true, silent = true },
        { "<leader>cl", "<cmd>nohl<cr>", desc = "Clear search highlights", icon = "󰃢" },
        -- Telescope shortcuts
        { "<leader>fw", telescope.live_grep, desc = "Find word", icon = "",  },
        { "<leader>ff", telescope.find_files, desc = "Find file", icon = "󰈞" },
        {
            "<leader>ee",
            function()
                telescope.buffers({ initial_mode = "normal" })
            end,
            desc = "Show open buffers",
            icon = "",
        },
        {
            "<leader>ef",
            function()
                telescope.oldfiles({ initial_mode = "normal" })
            end,
            desc = "Show recently opened files",
            icon = "󱋡",
        },
        { "<leader>q", "<cmd>:Bdelete<cr>", desc = "Close buffer, not window", icon = " ", noremap = true },
        {
            "<leader>/",
            function()
                telescope.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
                    previewer = false,
                })
            end,
            desc = "Find word in current buffer",
            icon = "󱎸",
        },
        { "<leader>1", "<cmd>NvimTreeToggle<cr>", desc = "Open file explorer", icon = "󰪶", noremap = true },
        { "<leader>sh", "<cmd>split<cr>", desc = "Split the window horizontally", icon = "" },
        { "<leader>sv", "<cmd>vsplit<cr>", desc = "Split the window vertically", icon = "" },
        { "<leader>h", "<c-w>h", desc = "Navigate to the buffer (left)", icon = "" },
        { "<leader>l", "<c-w>l", desc = "Navigate to the buffer (right)", icon = "" },
        { "<leader>j", "<c-w>j", desc = "Navigate to the buffer (down)", icon = "" },
        { "<leader>k", "<c-w>k", desc = "Navigate to the buffer (top)", icon = "" },
        -- Jumping
        { "<leader>o", "<c-o>", desc = "Jump: Go to older cursor position", icon = "", noremap = true },
        { "<leader>i", "<c-i>", desc = "Jump: Go to newer cursor position", icon = "", noremap = true },
        -- LSP Diagnostics
        { "<leader>dp", vim.diagnostic.goto_prev, desc = "Go to previous diagnostic message" },
        { "<leader>dn", vim.diagnostic.goto_next, desc = "Go to next diagnostic message" },
        { "<leader>dm", vim.diagnostic.open_float, desc = "Open floating diagnostic message" },
        { "<leader>dl", vim.diagnostic.setloclist, desc = " Show diagnostics list" },
        -- Git Integration
        {
            "<C-k>",
            function()
                if neogit.status:is_open() then
                    local instance = neogit.status.instance()
                    instance:close()
                else
                    neogit.open()
                end
            end,
            desc = "Toggle the Neogit popup",
        },
        -- Gitsigns
        { "]c", function() gitsigns.nav_hunk('next') end, desc = "Next git hunk", icon = "" },
        { "[c", function() gitsigns.nav_hunk('prev') end, desc = "Previous git hunk", icon = "" },
        { "<leader>gs", gitsigns.stage_hunk, desc = "Toggle stage hunk", icon = "" },
        { "<leader>gr", gitsigns.reset_hunk, desc = "Reset hunk", icon = "" },
        { "<leader>gS", gitsigns.stage_buffer, desc = "Stage buffer", icon = "" },
        { "<leader>gR", gitsigns.reset_buffer, desc = "Reset buffer", icon = "" },
        { "<leader>gp", gitsigns.preview_hunk, desc = "Preview hunk", icon = "" },
        { "<leader>gb", function() gitsigns.blame_line({ full = true }) end, desc = "Blame line", icon = "" },
        { "<leader>gB", gitsigns.toggle_current_line_blame, desc = "Toggle line blame", icon = "" },
        { "<leader>gd", gitsigns.diffthis, desc = "Diff this", icon = "" },
        { "<leader>gD", function() gitsigns.diffthis("~") end, desc = "Diff this (~)", icon = "" },
        -- Neoclip
        { "<leader>p", ":Telescope neoclip<cr>", desc = "Show clipboard history", icon = "󱛢"  },
        -- Refactoring
        { "<leader>ri", ":Refactor inline_var<cr>", desc = "Inline variable" },
        { "<leader>rI", ":Refactor inline_func<cr>", desc = "Inline function" },
        { "<leader>rb", ":Refactor extract_block<cr>", desc = "Extract block" },
        { "<leader>rbf", ":Refactor extract_block_to_file<cr>", desc = "Extract block to file" },
    },
    {
        mode = "i",
        { "<c-s>", "<cmd>w<cr>", desc = "Save changes", icon = "", nowait = true, silent = true },
    },
    {
        mode = "v",
        { "<s-j>", ":m '>+1<CR>gv=gv", desc = "Move one line down", icon = "" },
        { "<s-k>", ":m '<-2<CR>gv=gv", desc = "Move one line up", icon = "", },

    },
    {
        mode = { "x" },
        { "<leader>p", '"_dP', desc = "Paste without losing the last copied text", icon = " " },
        { "<leader>re", ":Refactor extract<cr>", desc = "Extract"},
        { "<leader>rf", ":Refactor extract_to_file<cr>", desc = "Extract to file" },
        { "<leader>rv", ":Refactor extract_var<cr>", desc = "Extract variable" },
        { "<leader>ri", ":Refactor inline_var<cr>", desc = "Inline variable" },
    },
})

local whickey_options = {
    spelling = {
        enabled = true,
        suggestions = 20,
    },
}

wk.setup(whickey_options)

vim.cmd [[ nmap <C-/> gcc ]]
vim.cmd [[ nmap <C-_> gcc ]]
vim.cmd [[ vmap <C-/> gc ]]
vim.cmd [[ vmap <C-_> gc ]]
