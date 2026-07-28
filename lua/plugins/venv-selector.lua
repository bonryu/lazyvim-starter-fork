-- restart_lsp_servers() only acts on vim.api.nvim_get_current_buf(),
-- so loop every loaded python buffer through nvim_buf_call to make
-- each one "current" for that lookup without switching windows.
local function restart_all_python_buffers()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype == "python" then
      vim.api.nvim_buf_call(buf, function()
        require("venv-selector").restart_lsp_servers()
      end)
    end
  end
end

return {
  {
    -- dir = "/home/bonryu/Projects/nvim/venv-selector.nvim/",
    "linux-cultist/venv-selector.nvim",
    branch = "main",
    cmd = "VenvSelect",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    ft = false,
    opts = {
      -- Built-in Linux default searches already cover this machine's env locations
      -- (pyenv -> ~/.pyenv/versions, miniconda_envs -> ~/miniconda3/envs,
      -- miniconda_base -> ~/miniconda3/bin), so no custom search paths needed here.
      options = {
        cached_venv_automatic_activation = false,
        -- venv-selector defaults this to true, which does `vim.notify =
        -- require("notify")` the first time it lazy-loads (on first
        -- <leader>Vs). Since noice.nvim (LazyVim's ui.lua) already owns
        -- vim.notify by then, that permanently clobbers noice's wrapper for
        -- the rest of the session, breaking its popup rendering for other
        -- plugins' messages (e.g. fzf-lua's "No definitions found").
        override_notify = false,
        -- debug = true,
      },
    },
    -- autocmd put into config/autocmds.lua to automatically activate cached envrionment
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { "<leader>Vs", "<cmd>VenvSelect<cr>", desc = "Select virtual env" },
      -- Keymap to deactivate the currently active venv (stops plugin-owned LSP clients, restores baseline config, clears PATH/env vars).
      {
        "<leader>Vd",
        function()
          -- venv-selector's own deactivate() clears path.current_python_path
          -- (venv.clear_active_state) *before* calling path.remove_current(),
          -- which only acts `if M.current_python_path then` -- so it's
          -- already nil and remove_current() silently no-ops, leaving the
          -- venv's bin dir in $PATH forever. Capture the path ourselves
          -- first and strip it after deactivate() returns.
          --
          -- deactivate()'s own LSP restart (hooks.restore_original_python_lsps_for_buf)
          -- is async (lsp_gate polls every 200ms before actually starting the
          -- replacement client), so this runs well before that timer fires -
          -- no need to force another restart ourselves here.
          local python_path = require("venv-selector").python()
          require("venv-selector").deactivate()
          if python_path then
            local path = require("venv-selector.path")
            local base = path.get_base(python_path)
            if base then
              path.remove(base)
            end
          end
        end,
        desc = "Deactivate venv",
      },
      {
        "<leader>Vr",
        "<cmd>lua require('venv-selector').restart_lsp_servers()<cr>",
        desc = "Restart python lsp clients (current buffer)",
      },
      {
        "<leader>VR",
        restart_all_python_buffers,
        desc = "Restart python lsp clients (all open buffers)",
      },
    },

    config = function(_, opts)
      require("venv-selector").setup(opts)
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      -- venv-selector's own "venv-selector" lualine component
      -- (venv-selector/statusline/lualine.lua) hardcodes
      -- `if vim.bo.filetype ~= "python" then return "" end`, so it only shows
      -- while focused on a python buffer. The active venv is actually global
      -- session state (path.current_venv_path isn't buffer-scoped), so build
      -- our own component without that gate -- it stays visible everywhere,
      -- which also makes it obvious what a freshly opened toggleterm panel
      -- will inherit.
      table.insert(opts.sections.lualine_x, {
        function()
          local venv_path = require("venv-selector").venv()
          if not venv_path or venv_path == "" then
            return ""
          end
          return "\u{F023A} " .. vim.fn.fnamemodify(venv_path, ":t") .. " "
        end,
        icon = "\u{1f332}",
        color = { fg = "#7fb55e" },
      })
    end,
  },
  {
    -- lazy.nvim's own `keys` table above only carries the actual keymap
    -- (desc included, since that's a real vim.keymap.set field); an `icon`
    -- field there is silently dropped since Neovim's keymap API doesn't
    -- store it. which-key only picks up icons from its own spec, so
    -- register icon-only entries here -- which-key merges them onto the
    -- real keymaps by lhs.
    "folke/which-key.nvim",
    optional = true,
    opts = function(_, opts)
      opts.spec = opts.spec or {}
      vim.list_extend(opts.spec, {
        { "<leader>Vs", icon = "\u{E606}" },
        { "<leader>Vd", icon = "\u{F011}" },
        { "<leader>Vr", icon = "\u{F01E}" },
        { "<leader>VR", icon = "\u{F021}" },
      })
      return opts
    end,
  },
}
