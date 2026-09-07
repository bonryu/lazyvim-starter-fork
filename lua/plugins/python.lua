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
      -- basedpyright sends some diagnostics (e.g. reportUnknownVariableType)
      -- as a two-line message: a generic summary line, then a more specific
      -- detail line with the inferred type and rule name. vim.diagnostic's
      -- virtual_text renderer doesn't split on "\n" (it just replaces it with
      -- spaces, jamming both lines onto one inline line), so this needs its
      -- own format hook in addition to float's - they're two separate config
      -- paths in vim.diagnostic, not one shared setting.
      diagnostics = (function()
        local function last_line(diagnostic)
          local lines = vim.split(diagnostic.message, "\n")
          return lines[#lines]
        end
        return {
          float = { format = last_line },
          virtual_text = { format = last_line },
        }
      end)(),
      servers = {
        ["*"] = {
          keys = {
            {
              "<leader>ch",
              function()
                -- Insert the inlay hint under the cursor as real source
                -- text. This mutates the buffer, so it belongs in the
                -- "<leader>c" (Code) group alongside ca/cr/cf, not the
                -- "gr" (goto) group nvim core uses for grr/gri/grt.
                --
                -- basedpyright embeds textEdits directly in the initial
                -- textDocument/inlayHint response and its
                -- inlayHintProvider capability is just `true` (no
                -- resolveProvider) - calling inlayHint/resolve on it
                -- errors with "Unhandled method". Other servers (e.g.
                -- rust-analyzer) resolve lazily instead, so only fall
                -- back to inlayHint/resolve when the server actually
                -- advertises support for it.
                local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
                for _, hint in ipairs(vim.lsp.inlay_hint.get({ bufnr = 0 })) do
                  if hint.inlay_hint.position.line == lnum then
                    local client = vim.lsp.get_client_by_id(hint.client_id)
                    local edits = hint.inlay_hint.textEdits
                    if not edits and client then
                      local caps = client.server_capabilities.inlayHintProvider
                      if type(caps) == "table" and caps.resolveProvider then
                        local resp = client:request_sync("inlayHint/resolve", hint.inlay_hint, 1000, hint.bufnr)
                        edits = resp and resp.result and resp.result.textEdits
                      end
                    end
                    if edits and client then
                      vim.lsp.util.apply_text_edits(edits, hint.bufnr, client.offset_encoding)
                      return
                    end
                  end
                end
                vim.notify("No resolvable inlay hint on this line", vim.log.levels.WARN)
              end,
              has = "inlayHint",
              desc = "Insert inlay hint under cursor as text",
            },
          },
        },
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
