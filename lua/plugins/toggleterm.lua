return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    -- cmd = "ToggleTerm",
    -- keys = { { [[<C-\>]], "<cmd>ToggleTerm<cr>", desc = "Toggle Term" } },
    opts = {--[[ things you want to change go here]]
      open_mapping = [[<c-\>]],
      insert_mappings = true,
      terminal_mappings = true,
    },
    config = function(_, opts)
      local toggleterm = require("toggleterm")
      toggleterm.setup(opts)

      function _G.set_terminal_keymaps()
        local opts2 = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts2)
        vim.api.nvim_buf_set_keymap(0, "t", "<A-h>", [[<C-\><C-n><C-W>h]], opts2)
        vim.api.nvim_buf_set_keymap(0, "t", "<A-j>", [[<C-\><C-n><C-W>j]], opts2)
        vim.api.nvim_buf_set_keymap(0, "t", "<A-k>", [[<C-\><C-n><C-W>k]], opts2)
        vim.api.nvim_buf_set_keymap(0, "t", "<A-l>", [[<C-\><C-n><C-W>l]], opts2)
      end

      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
  },
}
