-- Check for environment variables to conditionally load AI plugins
local plugins = {}

-- Include AmazonQ only when ENABLE_AMAZON_Q is set
if os.getenv("ENABLE_AMAZON_Q") == "1" then
  table.insert(plugins, {
    name = 'amazonq',
    url = 'ssh://git.amazon.com/pkg/AmazonQNVim',
    opts = {
      ssoStartUrl = 'https://amzn.awsapps.com/start',
      inline_suggest = true,
      filetypes = {
        'amazonq', 'bash', 'java', 'python', 'typescript', 'javascript', 'csharp', 'ruby', 'kotlin', 'sh', 'sql', 'c',
        'cpp', 'go', 'rust', 'lua',
      },
      on_chat_open = function()
        vim.cmd[[
          vertical topleft split
          set wrap breakindent nonumber norelativenumber nolist
        ]]
      end,
    },
    config = true,
  })
end

-- Include SuperMaven unless DISABLE_SUPERMAVEN is set
if os.getenv("DISABLE_SUPERMAVEN") ~= "1" then
  table.insert(plugins, {
    "supermaven-inc/supermaven-nvim",
    config = true,
  })
end

return plugins
