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
      { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select virtual env" },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
      { "<leader>vd", "<cmd>lua require('venv-selector').deactivate_venv()<cr>", desc = "Deactivate virtual env" },
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
