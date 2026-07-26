-- adding pyright to mason and lspconfig is done in plugins/lsp.lua
-- here we extend the opts.sources table for null-ls.nvim
-- if true then
--   return {}
-- end
return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "mypy")
      table.insert(opts.ensure_installed, "ruff")
      -- table.insert(opts.ensure_installed, "black")
      table.insert(opts.ensure_installed, "basedpyright")
      -- table.insert(opts.ensure_installed, "python-lsp-server")
      -- have to manuallly install to python3 provider environment pyhton-lsp-server[all], debugpy, pynvim, for maximum stability.
      opts.automatic_installation = { exclude = { "pylsp", "debugpy" } }
    end,
  },

  -- 2. Configure the LSP and the rope-plugin auto-installation, needed for class refactoring
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pylsp = {
          cmd = { vim.g.python_lsp_bin },
          filetypes = { "python" },
          -- basedpyright is the type-informed server for navigation; without
          -- this, telescope's `gd` shows two locations for the same symbol
          -- (pylsp/jedi resolves the venv via the pyenv symlink, basedpyright
          -- via the realpath). Keep pylsp for rope refactoring/completion only.
          on_attach = function(client)
            client.server_capabilities.definitionProvider = false
          end,
          settings = {
            pylsp = {
              plugins = {
                pyflakes = { enabled = false },
                -- basedpyright already answers textDocument/documentSymbol;
                -- leaving jedi_symbols on here made trouble.nvim's lualine
                -- breadcrumb show every symbol twice (once per LSP client).
                jedi_symbols = { enabled = false },
                pycodestyle = {
                  maxLineLength = 100,
                },
                -- Enable rope for refactoring (extracting, etc)
                rope_autoimport = { enabled = true },
                rope_completion = { enabled = true },
                jedi = {
                  extra_paths = { vim.fn.getcwd() }, -- Look in the current folder first
                  environment = vim.env.VIRTUAL_ENV, -- Use the project venv if active
                },
              },
            },
          },
        },
      },
    },
  },
  -- Keep dap "step over" from diving into neotest-python's own pytest
  -- hookwrapper (neotest_python/pytest.py, `outcome = yield`). debugpy's
  -- justMyCode only auto-excludes stdlib/site-packages, and this plugin
  -- lives under nvimLazy/lazy/, so it needs an explicit rule.
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        ["neotest-python"] = {
          dap = {
            rules = {
              { path = "**/neotest_python/**", include = false },
            },
          },
        },
      },
    },
  },

  -- {
  --   "nvimtools/none-ls.nvim",
  --   opts = function(_, opts)
  --     local nls = require("null-ls")
  --     -- table.insert(opts.sources, nls.builtins.formatting.autopep8)
  --     table.insert(
  --       opts.sources,
  --       nls.builtins.formatting.autopep8.with({
  --         extra_args = { "--indent-size=2" },
  --         -- extra_args = { "--indent-size=2 --ignore=E121" },
  --       })
  --     )
  --   end,
  -- },

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
