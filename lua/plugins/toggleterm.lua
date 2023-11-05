return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    -- cmd = "ToggleTerm",
    -- keys = { { [[<C-\>]], "<cmd>ToggleTerm<cr>", desc = "Toggle Term" } },
    config = true,
    opts = {--[[ things you want to change go here]]
      open_mapping = [[<c-\>]],
      insert_mappings = true,
      terminal_mappings = true,
    },
  },
}
