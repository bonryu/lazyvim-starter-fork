local wk = require("which-key")

wk.register({
  o = {
    name = "otter & code",
    a = { require("otter").dev_setup, "otter activate" },
    ["o"] = { "o# %%<cr>", "new code chunk below" },
    ["O"] = { "O# %%<cr>", "new code chunk above" },
    ["b"] = { "o```{bash}<cr>```<esc>O", "bash code chunk" },
    ["r"] = { "o```{r}<cr>```<esc>O", "r code chunk" },
    ["p"] = { "o```{python}<cr>```<esc>O", "python code chunk" },
    ["j"] = { "o```{julia}<cr>```<esc>O", "julia code chunk" },
    ["l"] = { "o```{julia}<cr>```<esc>O", "julia code chunk" },
  },
}, { mode = "n", prefix = "<leader>" })

return {

  -- which-key helps you remember key bindings by showing a popup
  -- with the active keybindings of the command you started typing.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      -- vim.list_extend(opts.defaults, {
      --   ["<leader>m"] = { name = "+molten" },
      -- })
      table.insert(opts.defaults, { ["<leader>m"] = { name = "+molten" } })
      table.insert(opts.defaults, { ["<leader>r"] = { name = "+quarto" } })
      table.insert(opts.defaults, { ["<leader>i"] = { name = "+slime" } })
    end,
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
