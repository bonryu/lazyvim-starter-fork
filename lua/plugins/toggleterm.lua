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
      clear_env = false,
      direction = "horizontal",
    },
    config = function(_, opts)
      local toggleterm = require("toggleterm")
      toggleterm.setup(opts)

      function _G.set_terminal_keymaps()
        local opts2 = { buffer = 0, noremap = true }
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts2)
        vim.keymap.set("t", "<A-h>", [[<C-\><C-n><C-W>h]], opts2)
        vim.keymap.set("t", "<A-j>", [[<C-\><C-n><C-W>j]], opts2)
        vim.keymap.set("t", "<A-k>", [[<C-\><C-n><C-W>k]], opts2)
        vim.keymap.set("t", "<A-l>", [[<C-\><C-n><C-W>l]], opts2)
      end

      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

      local Terminal = require("toggleterm.terminal").Terminal
      local floatterm = Terminal:new({
        direction = "float",
        hidden = true,
      })

      function _Floatterm_toggle()
        floatterm:toggle()
      end

      vim.keymap.set({ "n", "t" }, [[<A-\>]], "<cmd>lua _Floatterm_toggle()<CR>", { noremap = true, silent = true })
    end,
  },
}
