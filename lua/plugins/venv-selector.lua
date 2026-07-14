return {
  {
    -- dir = "/home/bonryu/Projects/nvim/venv-selector.nvim/",
    "linux-cultist/venv-selector.nvim",
    branch = "main",
    cmd = "VenvSelect",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    ft = false,
    opts = {
      parents = 0,
      anaconda_base_path = "/home/bonryu/miniconda3",
      anaconda_envs_path = "/home/bonryu/miniconda3/envs",
      pyenv_path = "/home/bonryu/.pyenv/versions",
      stay_on_this_version = true,

      -- enable_debug_output = true,
    },
    -- autocmd put into config/autocmds.lua to automatically activate cached envrionment
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { "<leader>Vs", "<cmd>VenvSelect<cr>", desc = "Select virtual env" },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { "<leader>Vc", "<cmd>lua require('venv-selector').deactivate()<cr>", desc = "Select chached env" },
      -- {
      --   "<leader>Vr",
      --   "<cmd>lua require('venv-selector').deactivate_venv()<cr><cmd>VenvSelectCached<cr>",
      --   desc = "Re-activate cached env",
      -- },
      {
        "<leader>Vr",
        "<cmd>lua require('venv-selector').restart_lsp_servers()<cr>",
        desc = "Restart python lsp clients",
      },
      -- {
      --   "<leader>Vr",
      --   function()
      --     -- 1. Save the file if there are unsaved changes so the reload doesn't complain
      --     if vim.bo.modified then
      --       vim.cmd("write")
      --     end
      --
      --     -- 2. Fetch active LSP clients safely (handles both Neovim 0.9 and 0.10+)
      --     local get_clients = vim.lsp.get_clients or vim.lsp.get_active_clients
      --     local clients = get_clients({ bufnr = 0 })
      --
      --     -- 3. Find your Python language server and shut it down cleanly
      --     for _, client in ipairs(clients) do
      --       if client.name == "pyright" or client.name == "pylsp" or client.name == "basedpyright" then
      --         vim.lsp.stop_client(client.id, true)
      --       end
      --     end
      --
      --     -- 4. Wait a fraction of a second for the shutdown, then reload the buffer in-place
      --     -- `:edit` triggers Neovim to resurrect the LSP from scratch, just like reopening the file!
      --     vim.defer_fn(function()
      --       vim.cmd("edit")
      --       print("Python LSP reloaded & packages indexed!")
      --     end, 200)
      --   end,
      --   desc = "Re-index packages (Safe Reload)",
      -- },
    },

    config = function(_, opts)
      require("venv-selector").setup(opts)
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, { "venv-selector", icon = "\u{1f332}", color = { fg = "#7fb55e" } })
    end,
  },
}
