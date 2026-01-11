return {
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    progress = {
      enabled = true,
    },
    hover = {
      enabled = true,
    },
  },
  presets = {
    command_palette = true,
    long_message_to_split = true,
    inc_rename = true,
    lsp_doc_border = true,
  },
  messages = {
    view_search = false,
  },
  routes = {
    {
      filter = { event = "notify", find = "No information available" },
      opts = { skip = true },
    },
    {
      filter = { error = true, find = "change; before" },
      opts = { skip = true },
    },
    {
      filter = { error = true, find = "changes; before" },
      opts = { skip = true },
    },
  },
}
