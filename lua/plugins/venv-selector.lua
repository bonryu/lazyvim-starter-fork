return {
  {
    dir = "/home/bonryu/Projects/nvim/venv-selector.nvim/",
    -- "linux-cultist/venv-selector.nvim",
    opts = {
      parents = 0,
      anaconda_base_path = "/home/bonryu/miniconda3",
      anaconda_envs_path = "/home/bonryu/miniconda3/envs",
    },
    -- autocmd put into config/autocmds.lua to automatically activate cached envrionment
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { "<leader>vs", "<cmd>VenvSelect<cr>" },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, { "venv-selector", icon = "\u{1f332}", color = { fg = "#7fb55e" } })
    end,
  },
}
