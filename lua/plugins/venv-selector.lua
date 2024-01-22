return {
  {
    dir = "/home/bonryu/Projects/nvim/venv-selector.nvim/",
    -- "linux-cultist/venv-selector.nvim",
    opts = {
      anaconda_base_path = "/home/bonryu/miniconda3",
      anaconda_envs_path = "/home/bonryu/miniconda3/envs",
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
