-- return {
--   -- add pyright to lspconfig
--   {
--     "neovim/nvim-lspconfig",
--     ---@class PluginLspOpts
--     opts = {
--
--       ---@type lspconfig.options
--       servers = {
--         -- pyright will be automatically installed with mason and loaded with lspconfig
--         pyright = {
--           extra_args = function()
--             local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
--             return { "--python-executable", virtual .. "/bin/python" }
--           end,
--         },
--       },
--     },
--   },
-- }

return {

  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          -- Use this to add any additional keymaps
          -- for specific lsp servers
          ---@type LazyKeysSpec[]
          -- keys = {},
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
              },
            },
          },
        },
      },
    },
  },
}
