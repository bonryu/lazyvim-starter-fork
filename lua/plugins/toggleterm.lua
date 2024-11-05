return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    -- cmd = "ToggleTerm",
    -- keys = { { [[<C-\>]], "<cmd>ToggleTerm<cr>", desc = "Toggle Term" } },
    opts = {--[[ things you want to change go here]]
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
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

      local vertterm = Terminal:new({
        direction = "vertical",
        hidden = true,
      })
      function _Vertterm_toggle()
        vertterm:toggle()
      end
      vim.keymap.set({ "n", "t" }, [[<A-\>]], "<cmd>lua _Floatterm_toggle()<CR>", { noremap = true, silent = true })
      vim.keymap.set({ "n", "t" }, [[<C-A-\>]], "<cmd>lua _Vertterm_toggle()<CR>", { noremap = true, silent = true })
    end,
  },
}
