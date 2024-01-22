if true then
  return {}
end

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- opts.disabled_filetypes = {
      --   statusline = {},
      --   winbar = { "neo-tree" },
      -- }
      -- opts.sections.lualine_c = { { "filename", path = 2 } }
      -- opts.sections.lualine_c = {
      --   lualine_a = { "mode" },
      --   lualine_b = { "branch", "diff", "diagnostics" },
      --   lualine_c = { { "filename", path = 4 } },
      --   lualine_x = { "encoding", "fileformat", "filetype" },
      --   lualine_y = { "progress" },
      --   lualine_z = { "location" },
      -- }
      --opts.winbar.lualine_z = { "filename" }
      opts.winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        -- lualine_z = {},
        lualine_z = { { "filename" } },
      }
      opts.inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        -- lualine_z = {},
        lualine_z = { { "filename" } },
      }
      -- opts.extensions = { "neo-tree" }
      opts.sections.lualine_c = {}
    end,
  },
}
