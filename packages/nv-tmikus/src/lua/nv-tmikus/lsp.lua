local telescope = require "telescope.builtin"

local function format(bufnr)
    vim.lsp.buf.format {
        bufnr = bufnr,
        timeout_ms = 500,
    }
end

-- Configure diagnostics with signs
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
        },
    },
    float = {
        focus = false,
        focusable = false,
        border = "rounded",
    }
})

-- Create augroups once at module load
local lsp_attach_group = vim.api.nvim_create_augroup("TmikusLspAttach", { clear = true })
local format_on_save_group = vim.api.nvim_create_augroup("TmikusFormatOnSave", { clear = true })

--  This autocmd gets run when an LSP connects to a particular buffer.
vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_attach_group,
    callback = function(args)
        local bufnr = args.buf

        local nmap = function(keys, func, desc)
            if desc then
                desc = "LSP: " .. desc
            end
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        nmap("<leader>rn", vim.lsp.buf.rename, " Rename symbol")
        nmap("<leader>ca", vim.lsp.buf.code_action, " Show code actions")

        nmap("<leader>gd", vim.lsp.buf.definition, " Go to definition")
        nmap("<leader>cr", telescope.lsp_references, " Show references")
        nmap("<leader>ci", vim.lsp.buf.implementation, " Show implementation")
        nmap("<leader>cy", vim.lsp.buf.type_definition, " Type definition")
        nmap("<leader>ds", telescope.lsp_document_symbols, "[D]ocument [S]ymbols")
        nmap("<leader>ws", telescope.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        nmap("<leader>cd", vim.lsp.buf.hover, " Show documentation")
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

        -- Format on save - clear existing autocmds for this buffer first
        vim.api.nvim_clear_autocmds({ group = format_on_save_group, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = format_on_save_group,
            buffer = bufnr,
            callback = function()
                local client = vim.lsp.get_clients({ bufnr = bufnr })[1]
                if client and client.server_capabilities.documentFormattingProvider then
                    format(bufnr)
                end
            end,
        })
    end
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

-- Ensure the servers above are installed
local mason_lspconfig = require "mason-lspconfig"
-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself:
-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
local all_servers = {
    emmet_ls = {
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
    },
    eslint = {},
    gopls = {},
    jsonls = {},
    lua_ls = {
        cmd = { os.getenv("HOME") .. "/.nix-profile/bin/lua-language-server" },
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
    pyright = {},
    cssls = {},
    rust_analyzer = {
        cmd = { os.getenv("HOME") .. "/.nix-profile/bin/rust-analyzer" },
    },
    ts_ls = {},
}

-- Setup the LSP config for each server with capabilities
for server_name, server_config in pairs(all_servers) do
    server_config.capabilities = capabilities
    vim.lsp.config(server_name, server_config)
end

-- Tell the Mason LSP to install the servers above
mason_lspconfig.setup({
    automatic_enable = true,
    ensure_installed = vim.tbl_keys(all_servers),
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

null_ls.setup({
    border = "rounded",
    sources = formatting_sources,
})

-- mason-null-ls config
require("mason-null-ls").setup({
    ensure_installed = vim.tbl_keys(all_formatters),
    automatic_installation = true,
})

-- Start go lang support
require("go").setup()

-- Mason NVIM Lint
require("mason-nvim-lint").setup(require("nv-tmikus.configs.nvim-lint"))
