if true then
  return {}
end
return {
  {
    "AckslD/swenv.nvim",
    opts = {
      -- Should return a list of tables with a `name` and a `path` entry each.
      -- Gets the argument `venvs_path` set below.
      -- By default just lists the entries in `venvs_path`.
      get_venvs = function(venvs_path)
        return require("swenv.api").get_venvs(venvs_path)
      end,
      -- Path passed to `get_venvs`.
      venvs_path = vim.fn.expand("$HOME/miniconda3/envs"),
      -- Something to do after setting an environment, for example call vim.cmd.LspRestart
      post_set_venv = function()
        -- vim.cmd("source " .. vim.fn.stdpath("config") .. "/config/options.lua")
        -- vim.cmd("source " .. vim.fn.stdpath("config") .. "/plugins/python.lua")
        br.set_env()
        vim.cmd("LspRestart")
      end,
      -- post_set_venv = vim.cmd.LspRestart,
      -- post_set_venv = vim.cmd.source("~/.local/nvim/plugins/python.lua"),
      -- post_set_venv = vim.cmd('source ' vim.fn.stdpath("config") .. "/plugins/python.lua"),
      -- post_set_venv = vim.cmd("echo hi"), -- function()
      -- post_set_venv = vim.cmd("source " .. vim.fn.stdpath("config") .. "/plugins/python.lua"),
      -- post_set_venv = function()
      --   vim.cmd("source " .. vim.fn.stdpath("config") .. "/plugins/python.lua")
      --   vim.cmd("LspRestart")
      -- end,
    },
    config = function(_, opts)
      local swenv = require("swenv")
      local swenvapi = require("swenv.api")
      swenv.setup(opts)
      -- local swenvapi = require("swenv.api")
      vim.api.nvim_create_user_command("SwenvPick", swenvapi.pick_venv, {})
    end,
  },
  -- lualine integration
  -- square 
  -- house \u{1f3e0}
  -- pine tree \u{1f332}
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, { "swenv", icon = "\u{1f332}", color = { fg = "#7fb55e" } })
    end,
  },
}
