-- if true then
--   return {}
-- end
local hint = br.notebookhint
-- local hint = [[
--  _j_/_k_: move down/up    _r_: run cell
--  _l_: run line            _R_: run above
--  ^^_<esc>_/_q_: exit
--  ]]
return {
  {
    "nvimtools/hydra.nvim",
  },
  {
    "GCBallesteros/NotebookNavigator.nvim",
    dir = "/home/bonryu/Projects/nvim/NotebookNavigator.nvim/",
    opts = {
      -- activate_hydrakeys = "<leader>h",
      -- exclude = { "quarto", "markdown", "ipynb" },
      exclude = {
        filetypes = { "", nil, "git" },
      },
      repl_provider = "molten",
    },
    ft = { "python" },
    dependencies = {
      "echasnovski/mini.comment",
      -- "hkupty/iron.nvim", -- repl provider
      -- "akinsho/toggleterm.nvim", -- alternative repl provider
      "benlubas/molten-nvim", -- alternative repl provider
      "nvimtools/hydra.nvim",
      -- "anuvyklack/hydra.nvim",
    },
    event = "VeryLazy",
    keys = {
      -- {
      --   "]i",
      --   function()
      --     require("notebook-navigator").move_cell("d")
      --   end,
      --   desc = "notebooknavig move_cell(d)",
      --   ft = "python",
      -- },
      -- {
      --   "[i",
      --   function()
      --     require("notebook-navigator").move_cell("u")
      --   end,
      --   desc = "notebooknavig move_cell(u)",
      --   ft = "python",
      -- },
      { "<leader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
      { "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
    },
    config = function(_, opts)
      local nn = require("notebook-navigator")
      nn.setup(opts)
    end,
  },

  {
    "echasnovski/mini.hipatterns",
    event = "VeryLazy",
    dependencies = { "GCBallesteros/NotebookNavigator.nvim" },
    opts = function()
      local nn = require("notebook-navigator")

      local opts = { highlighters = { cells = nn.minihipatterns_spec } }
      return opts
    end,
  },

  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    dependencies = { "GCBallesteros/NotebookNavigator.nvim" },
    opts = function()
      local nn = require("notebook-navigator")

      local opts = { custom_textobjects = { y = nn.miniai_spec, desc = "notebook cell" } }
      return opts
    end,
  },
}
