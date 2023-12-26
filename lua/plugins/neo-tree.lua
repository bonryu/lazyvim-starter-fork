return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      table.insert(opts.filesystem, { bind_to_cwd = true })
      table.insert(opts.window, { auto_expand_width = false })
    end,
  },
}
