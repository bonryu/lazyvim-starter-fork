return {
  {
    "williamboman/mason.nvim",
    -- opts = function(_, opts)
    --   PATH = "append",
    -- end,
    opts = {
      PATH = "append",
      log_level = vim.log.levels.DEBUG,
    },
  },
}
