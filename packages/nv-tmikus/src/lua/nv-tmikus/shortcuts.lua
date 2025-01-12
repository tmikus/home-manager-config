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
        { "<C-S-n>", telescope.find_files, desc = "Find file" },
        { "<c-f>", telescope.live_grep, desc = "Find word" },
        { "<c-e>", telescope.buffers, desc = "Show buffers" },
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
        { "<c-1>", "<cmd>NvimTreeToggle<cr>", desc = "Open file explorer", noremap = true },
        { "<leader>sh", "<cmd>split<cr>", desc = "Split the window horizontally" },
        { "<leader>sv", "<cmd>vsplit<cr>", desc = "Split the window vertically" },
        { "<C-LEFT>", "<c-w>h", desc = "Navigate to the buffer (left)" },
        { "<C-RIGHT>", "<c-w>l", desc = "Navigate to the buffer (right)" },
        { "<C-DOWN>", "<c-w>j", desc = "Navigate to the buffer (down)" },
        { "<C-UP>", "<c-w>k", desc = "Navigate to the buffer (top)" },
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
        -- ["<C-k>"] = { "<cmd>DiffviewOpen<cr>", "Open the git diff", noremap = true },
        -- ["<C-S-k>"] = { "<cmd>DiffviewClose<cr>", "Close the git diff", noremap = true },
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
