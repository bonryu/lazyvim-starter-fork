-- adding pyright to mason and lspconfig is done in plugins/lsp.lua
-- here we extend the opts.sources table for null-ls.nvim
-- if true then
--   return {}
-- end
return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "mypy")
      table.insert(opts.ensure_installed, "ruff")
      table.insert(opts.ensure_installed, "black")
      table.insert(opts.ensure_installed, "pyright")
      table.insert(opts.ensure_installed, "autopep8")
      table.insert(opts.ensure_installed, "debugpy")
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      table.insert(opts.sources, nls.builtins.formatting.autopep8)
    end,
  },

  -- {
  --   "nvimtools/none-ls.nvim",
  --   opts = function(_, opts)
  --     local nls = require("null-ls")
  --     table.insert(
  --       opts.sources,
  --       nls.builtins.diagnostics.mypy.with({
  --         extra_args = br.python_extra_args,
  --       })
  --     )
  --     table.insert(
  --       opts.sources,
  --       nls.builtins.diagnostics.ruff.with({
  --         extra_args = br.python_extra_args,
  --       })
  --     )
  --   end,
  -- },
  -- {
  --   "neovim/nvim-lspconfig",
  --   -- ---@class PluginLspOpts
  --   -- opts = {
  --   --   ---@type lspconfig.options
  --   --   servers = {
  --   --     -- pyright will be automatically installed with mason and loaded with lspconfig
  --   --     pyright = {
  --   --       -- extra_args = function()
  --   --       --   local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
  --   --       --   return { "--python-executable", virtual .. "/bin/python" }
  --   --       -- end,
  --   --     },
  --   --   },
  --   -- },
  --   opts = function(_, opts)
  --     table.insert(opts.servers.pyright, {
  --       extra_args = br.python_extra_args,
  --     })
  --   end,
  -- },
}
