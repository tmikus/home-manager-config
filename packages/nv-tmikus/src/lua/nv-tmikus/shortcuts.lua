local wk = require "which-key"
local telescope = require "telescope.builtin"
local neogit = require "neogit"

-- Settings the leader
vim.g.mapleader = " "

wk.add({
    {
        mode = "n",
        -- General
        { "<c-s>", "<cmd>w<cr>", desc = "Save changes", nowait = true, silent = true },
        { "<leader>cl", "<cmd>nohl<cr>", desc = " Clear search highlights" },
        -- Telescope shortcuts
        { "<leader>fw", telescope.live_grep, desc = "Find word" },
        { "<leader>ff", telescope.find_files, desc = "Find file" },
        { "<leader>e", telescope.buffers, desc = "Show buffers" },
        { "<leader>q", "<cmd>:Bdelete<cr>", desc = " Close buffer, not window", noremap = true },
        {
            "<leader>/",
            function()
                telescope.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
                    previewer = false,
                })
            end,
            desc = "Find word in current buffer",
        },
        { "<leader>1", "<cmd>NvimTreeToggle<cr>", desc = "Open file explorer", noremap = true },
        { "<leader>sh", "<cmd>split<cr>", desc = "Split the window horizontally" },
        { "<leader>sv", "<cmd>vsplit<cr>", desc = "Split the window vertically" },
        { "<leader>h", "<c-w>h", desc = "Navigate to the buffer (left)" },
        { "<leader>l", "<c-w>l", desc = "Navigate to the buffer (right)" },
        { "<leader>j", "<c-w>j", desc = "Navigate to the buffer (down)" },
        { "<leader>k", "<c-w>k", desc = "Navigate to the buffer (top)" },
        -- ["<c-h>"] = { "<c-w>h", "Navigate to the buffer (left)" },
        -- ["<c-l>"] = { "<c-w>l", "Navigate to the buffer (right)" },
        -- ["<c-j>"] = { "<c-w>j", "Navigate to the buffer (down)" },
        -- ["<c-k>"] = { "<c-w>k", "Navigate to the buffer (top)" },
        -- Jumping
        { "<leader>o", "<c-o>", desc = "Jump: Go to older cursor position", noremap = true },
        { "<leader>i", "<c-i>", desc = "Jump: Go to newer cursor position", noremap = true },
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
        -- Neoclip
        { "<leader>p", ":Telescope neoclip<cr>", desc = "Show clipboard history", icon = ""  },
        -- Refactoring
        { "<leader>ri", ":Refactor inline_var<cr>", desc = "Inline variable" },
        { "<leader>rI", ":Refactor inline_func<cr>", desc = "Inline function" },
        { "<leader>rb", ":Refactor extract_block<cr>", desc = "Extract block" },
        { "<leader>rbf", ":Refactor extract_block_to_file<cr>", desc = "Extract block to file" },
    },
    {
        mode = "i",
        { "<c-s>", "<cmd>w<cr>", desc = "Save changes", nowait = true, silent = true },
    },
    {
        mode = "v",
        { "<s-j>", ":m '>+1<CR>gv=gv", desc = " Move one line down" },
        { "<s-k>", ":m '<-2<CR>gv=gv", desc = " Move one line up" },
    },
    {
        mode = { "x" },
        { "<leader>p", '"_dP', desc = " Paste without losing the last copied text" },
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
