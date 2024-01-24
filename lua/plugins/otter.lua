return {

  {
    "jmbuhr/otter.nvim",
    ft = "quarto",
    opts = {
      buffers = {
        set_filetype = true,
      },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = { "jmbuhr/otter.nvim" },
    opts = function(_, opts)
      ---@param opts cmp.ConfigSchema
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "otter" } }))
    end,
  },
}
