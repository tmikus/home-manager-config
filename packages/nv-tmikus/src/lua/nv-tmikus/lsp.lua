require("neodev").setup({
    library = {
        plugins = { "nvim-dap-ui" },
        types = true,
    },
})

-- NullJS configuration
local null_ls = require("null-ls")
local all_formatters = {
    eslint_d = {
      extra_args = { "--stdin", "--fix-to-stdout" },
    },
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
local formatting_sources = {}
for k, v in pairs(all_formatters) do
    table.insert(formatting_sources, null_ls.builtins.formatting[k].with(v))
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
    border = "rounded",
    sources = formatting_sources,
    -- Format on save (dependencies that does not work with Mason)
    on_attach = function(client, bufnr)
        local should_format_on_save = helpers.get_config_item { "flags", "format_on_save" }
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

-- mason-null-ls config (anything that can't be auto installed by mason)
require("mason-null-ls").setup({
    ensure_installed = vim.tbl_keys(all_formatters),
})

-- Border for LspInfo window
require("lspconfig.ui.windows").default_options.border = "single"


