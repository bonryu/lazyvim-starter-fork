if false then
  return {}
end
return {
  {
    "williamboman/mason.nvim",
    -- opts = function(_, opts)
    --   PATH = "append",
    -- end,
    opts = function(_, opts)
      table.insert(opts, { PATH = "prepend" })
      table.insert(opts, { log_level = vim.log.levels.DEBUG })
      vim.list_extend(opts.ensure_installed, {
        "r-languageserver",
      })
    end,
  },
}
