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
        -- No Alt+hjkl here: the global terminal-mode maps in config/keymaps.lua
        -- resize with Alt+hjkl, the same as everywhere else.
      end

      -- Checks the job's argv as well as the buffer name: claudecode.nvim launches
      -- `env -u TMUX claude` (see ai_claudecode.lua), so the buffer is named after
      -- /usr/bin/env and the name alone no longer says "claude".
      local function is_claude_terminal(buf)
        if vim.api.nvim_buf_get_name(buf):match("claude") then
          return true
        end
        local channel = vim.bo[buf].channel
        local argv = channel ~= 0 and vim.api.nvim_get_chan_info(channel).argv or {}
        for _, arg in ipairs(argv) do
          if arg:match("claude") then
            return true
          end
        end
        return false
      end

      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*",
        desc = "Set toggleterm keymaps, except in the claudecode.nvim panel (own <esc>; Alt+hjkl resizes there)",
        callback = function(args)
          if not is_claude_terminal(args.buf) then
            set_terminal_keymaps()
          end
        end,
      })

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
