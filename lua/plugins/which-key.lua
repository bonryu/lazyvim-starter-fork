-- if true then
--   return {}
-- end
return {

  -- which-key helps you remember key bindings by showing a popup
  -- with the active keybindings of the command you started typing.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      vim.list_extend(opts.spec, {
        {
          mode = { "n", "v" },
          { "<leader>m", group = "molten" },
          { "<leader>r", group = "quarto" },
          { "<leader>rr", group = "quarto runs" },
          { "<leader>rs", group = "quarto sends" },
          { "<leader>i", group = "slime" },
          { "<leader>v", group = "Overseer" },
          { "<leader>V", group = "venv-selector" },
          { "<leader>j", group = "IPythonCell" },
          { "<leader>F", group = "FuGitive" },
          { "<leader>h", group = "Hydras" },
        },
      })
      -- vim.list_extend(opts.defaults, {
      --   ["<leader>m"] = { name = "+molten" },
      -- })

      -- Need to table.insert because Lazyvim has default bindings we don't want to override
      -- Other option is to use require("which-key").regiester() inside config function
      -- table.insert(opts.spec, { ["<leader>m"] = { name = "+molten" } })
      -- table.insert(opts.spec, { ["<leader>r"] = { name = "+quarto" } })
      -- table.insert(opts.spec, { ["<leader>rr"] = { name = "+quarto runs" } })
      -- table.insert(opts.spec, { ["<leader>rs"] = { name = "+quarto sends" } })
      -- table.insert(opts.spec, { ["<leader>i"] = { name = "+slime" } })
      -- table.insert(opts.spec, { ["<leader>v"] = { name = "+Overseer" } })
      -- table.insert(opts.spec, { ["<leader>j"] = { name = "+IPythonCell" } })
      -- table.insert(opts.spec, { ["<leader>F"] = { name = "+FuGitive" } })
    end,
    -- -- From ~/.local/share/nvimLazy/lazy/LazyVim/lua/lazyvim/plugins/editor.lua
    -- "folke/which-key.nvim",
    -- event = "VeryLazy",
    -- opts = {
    --   plugins = { spelling = true },
    --   defaults = {
    --     mode = { "n", "v" },
    --     ["g"] = { name = "+goto" },
    --     ["gs"] = { name = "+surround" },
    --     ["]"] = { name = "+next" },
    --     ["["] = { name = "+prev" },
    --     ["<leader><tab>"] = { name = "+tabs" },
    --     ["<leader>b"] = { name = "+buffer" },
    --     ["<leader>c"] = { name = "+code" },
    --     ["<leader>f"] = { name = "+file/find" },
    --     ["<leader>g"] = { name = "+git" },
    --     ["<leader>gh"] = { name = "+hunks" },
    --     ["<leader>q"] = { name = "+quit/session" },
    --     ["<leader>s"] = { name = "+search" },
    --     ["<leader>u"] = { name = "+ui" },
    --     ["<leader>w"] = { name = "+windows" },
    --     ["<leader>x"] = { name = "+diagnostics/quickfix" },
    --     ["<leader>m"] = { name = "+molten" },
    --   },
    -- },
    -- config = function(_, opts)
    --   local wk = require("which-key")
    --   wk.setup(opts)
    --   wk.register(opts.defaults)
    -- end,
  },
}
