return {
  {
    "luk400/vim-jukit",
    version = "*",
    config = function()
      -- local jukit = require('vim-jukit')
      -- jukit.setup(opts)
      -- vim.g.jukit_mpl_style = vim.cmd("echo jukit#util#plugin_path()")
      --   .. "/helpers/matplotlib-backend-kitty/backend.mplstyle"
      vim.keymap.set({ "n", "v" }, "<leader>js", "<cmd>call jukit#send#line()<cr>")

      vim.keymap.set("n", "<leader>so", "<Nop>")
      vim.keymap.set("n", "<leader>so", "<cmd>call jukit#splits#show_last_cell_output(1)<cr>")
      -- look at ./local/share/nvim/laxy/LazyVim/lua/plugins/editor.lua to see example of adding addtional options to which key
      -- vim.g.jukit_mappings = 0

      -- vim.keymap.set("n", "<leader>os", "<Nop>")
      -- vim.keymap.set(
      --   "n",
      --   "<leader>os",
      --   "<cmd>call jukit#splits#output('conda activate ' . $CONDA_PREFIX)<cr>",
      --   { desc = " split output " }
      -- )
      vim.g.jukit_shell_cmd = "ipython3"
      vim.g.jukit_terminal = "nvimterm"
      vim.g.jukit_inline_plotting = 1
      vim.g.jukit_hist_use_ueberzug = 1
      -- vim.g.jukit_terminal = 'kitty --listen-on=unix:@"$(date +%s%N)" -o allow_remote_control=yes'
    end,
  },
}
