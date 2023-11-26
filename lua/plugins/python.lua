-- adding pyright to mason and lspconfig is done in plugins/lsp.lua
-- here we extend the opts.sources table for null-ls.nvim

return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "mypy")
      table.insert(opts.ensure_installed, "ruff")
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("none-ls")
      local extra_args = function()
        local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
        return { "--python-executable", virtual .. "/bin/python" }
      end
      table.insert(
        opts.sources,
        nls.builtins.diagnostics.mypy.with({
          extra_args = extra_args,
        })
      )
      table.insert(
        opts.sources,
        nls.builtins.diagnostics.ruff.with({
          extra_args = extra_args,
        })
      )
    end,
  },
}
