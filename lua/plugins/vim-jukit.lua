if false then return {} end

return {
  {
    "luk400/vim-jukit",
    version = "*",
    config = function()
      -- local jukit = require('vim-jukit')
      -- jukit.setup(opts)
      vim.g.jukit_mpl_style = vim.cmd('echo jukit#util#plugin_path()') ..
          '/helpers/matplotlib-backend-kitty/backend.mplstyle'
      vim.keymap.set({ "n", "v" }, "<leader>js", "<cmd>call jukit#send#line()<cr>")
      -- look at ./local/share/nvim/laxy/LazyVim/lua/plugins/editor.lua to see example of adding addtional options to which key
      -- vim.g.jukit_mappings = 0
      vim.g.jukit_shell_cmd = 'ipython3'
      vim.g.jukit_terminal = 'kitty'
      vim.g.jukit_inline_plotting = 1
      -- vim.g.jukit_terminal = 'kitty --listen-on=unix:@"$(date +%s%N)" -o allow_remote_control=yes'
    end,
  },
}
