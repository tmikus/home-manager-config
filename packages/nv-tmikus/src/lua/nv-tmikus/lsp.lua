local utils = require "nv-tmikus.utils"
local telescope = require "telescope.builtin"

local function format(bufnr)
    vim.lsp.buf.format {
        bufnr = bufnr,
        formatting_options = {
            timeout_ms = 100,
        }
    }
end

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    -- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    local config = {
        signs = {
            active = signs,
        },
        float = {
            focus = false,
            focusable = false,
            border = "rounded",
        }
    }

    vim.diagnostic.config(config)

    nmap("<leader>rn", vim.lsp.buf.rename, " Rename symbol")
    nmap("<leader>ca", vim.lsp.buf.code_action, " Show code actions")

    nmap("<leader>gd", vim.lsp.buf.definition, " Go to definition")
    nmap("<leader>cr", telescope.lsp_references, " Show references")
    nmap("<leader>ci", vim.lsp.buf.implementation, " Show implementation")
    nmap("<leader>cy", vim.lsp.buf.type_definition, " Type definition")
    nmap("<leader>ds", telescope.lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", telescope.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    nmap("<leader>cd", vim.lsp.buf.hover, " Show documentation")
    nmap("<leader>cs", vim.lsp.buf.signature_help, "Signature Documentation")
    nmap("<leader>ll", vim.lsp.codelens.run, "Run code lens action")

    -- Lesser used LSP functionality
    nmap("<leader>gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        format(bufnr)
    end, { desc = "Format current buffer with LSP" })

    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("TmikusFormatOnSave", { clear = true }),
        buffer = bufnr,
        callback = function()
            local should_format_on_save = true
            local client = vim.lsp.get_active_clients({ filter = { bufnr = bufnr } })[1]
            local can_format_client = client.supports_method("textDocument/formatting")
            if should_format_on_save and can_format_client then
                format(bufnr)
            end
        end,
    })
end

-- Setup neovim lua configuration
require("neodev").setup({
    library = {
        plugins = { "nvim-dap-ui" },
        types = true,
    }
})

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Setup mason so it can manage external tooling
require("mason").setup({
    ui = {
        border = "rounded",
    },
})

local function get_custom_lsp_config(tbl)
    local custom_settings = tbl.settings
    local custom_on_attach = type(tbl.on_attach) == "function" and tbl.on_attach or nil
    local has_no_settings_in_table = not (type(custom_settings) == "table" or type(custom_on_attach) == "function") and
        utils.table_length(tbl) > 0

    if has_no_settings_in_table then
        vim.notify_once(
            "You should use `settings` to configure LSPs.",
            vim.log.levels.WARN
        )
        custom_settings = tbl
    end

    return {
        settings = custom_settings,
        on_attach = custom_on_attach,
    }
end

-- Ensure the servers above are installed
local mason_lspconfig = require "mason-lspconfig"
local lspconfig = require "lspconfig"
-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself:
-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
local all_servers = {
    emmet_ls = {},
    eslint = {},
    gopls = {},
    jsonls = {},
    lua_ls = {
        settings = {
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
                diagnostics = {
                    globals = { "vim" },
                },
                format = {
                    enable = true,
                    -- Possible options for format: https://github.com/CppCXY/EmmyLuaCodeStyle/blob/master/lua.template.editorconfig
                    defaultConfig = {
                        align_array_table = "none",
                    },
                },
            },
        },
    },
    markdown_oxide = {},
    rust_analyzer = {},
    ts_ls = {},
}

-- Setup the LSP config for each server
for server_name, server_config in pairs(all_servers) do
    vim.lsp.config(server_name, server_config)
end

-- Tell the Mason LSP to install the servers above
mason_lspconfig.setup({
    automatic_enable = true,
    ensure_installed = vim.tbl_keys(all_servers),
})

lspconfig.emmet_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = {
        "css",
        "eruby",
        "html",
        "javascript",
        "javascriptreact",
        "less",
        "sass",
        "scss",
        "svelte",
        "pug",
        "typescriptreact",
        "vue"
    },
    init_options = {
        html = {
            options = {
                ["bem.enabled"] = true,
            },
        },
    },
})

lspconfig.lua_ls.setup({
    cmd = { os.getenv("HOME") .. "/.nix-profile/bin/lua-language-server" }
})

lspconfig.rust_analyzer.setup({
    cmd = { os.getenv("HOME") .. "/.nix-profile/bin/rust-analyzer" }
})

-- NoneLS config
local null_ls = require("null-ls")
local all_formatters = {
    goimports = {},
    prettier = {
        filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "css",
            "scss",
            "less",
            "html",
            "json",
            "jsonc",
            "yaml",
            "markdown",
            "markdown.mdx",
            "graphql",
            "handlebars",
            "astro",
        },
        condition = function(utils)
            return utils.root_has_file({
                ".prettierrc",
                ".prettierrc.json",
                ".prettierrc.yml",
                ".prettierrc.yaml",
                ".prettierrc.json5",
                ".prettierrc.js",
                ".prettierrc.cjs",
                ".prettier.config.js",
                ".prettier.config.cjs",
                ".prettierrc.toml",
            })
        end,
    },
}
local formatting_sources = {
    require("none-ls.diagnostics.eslint_d").with({
        extra_args = { "--stdin", "--fix-to-stdout" },
    })
}
for k, v in pairs(all_formatters) do
    table.insert(formatting_sources, null_ls.builtins.formatting[k].with(v))
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
    border = "rounded",
    sources = formatting_sources,
    -- Format on save (dependencies that does not work with Mason)
    on_attach = function(client, bufnr)
        local should_format_on_save = true
        local can_format_client = client.supports_method("textDocument/formatting")
        if should_format_on_save and can_format_client then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    format(bufnr)
                end,
            })
        end
    end,
})

-- mason-null-ls config
require("mason-null-ls").setup({
    ensure_installed = vim.tbl_keys(all_formatters),
})

-- Start go lang support
require("go").setup()

require("lspconfig.ui.windows").default_options.border = "single"

-- Mason NVIM Lint
require("mason-nvim-lint").setup(require("nv-tmikus.configs.nvim-lint"))
