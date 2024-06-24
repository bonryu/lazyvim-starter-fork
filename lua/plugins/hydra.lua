-- if true then
--   return {}
-- end
local hint = br.notebookhint
return {
  {
    "nvimtools/hydra.nvim",
    dependencies = {
      "GCBallesteros/NotebookNavigator.nvim",
      "rcarriga/nvim-notify",
      "quarto-dev/quarto-nvim",
    },
    -- init = function() end,
    config = function()
      -- local notify = require("notify")
      -- local quarto = require("quarto")
      -- local qrunner = require("quarto.runner")
      local function keys(str)
        return function()
          --  "m" means remap keys
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(str, true, false, true), "m", true)
        end
      end
      local Hydra = require("hydra")
      Hydra({
        name = "QuartoNotebook",
        hint = ""
          .. "_j_/_k_: ↓/↑    _o_/_O_: new cell ↓/↑    _d_/_e_: swap ↓/↑"
          .. string.char(10)
          .. "_r_un _a_bove      _R_un and move      _s_how/_h_ide",
        config = {
          color = "pink",
          invoke_on_body = true,
          hint = {
            float_opts = {
              border = "rounded", -- you can change the border if you want
            },
          },
        },
        mode = { "n" },
        body = "<leader>hr",
        heads = {
          { "j", keys("]x"), { desc = "↓" } },
          { "k", keys("[x"), { desc = "↑" } },
          { "o", keys("/```<CR>:nohl<CR>o<CR>pyc<C-e>"), { desc = "new cell ↓", exit = true } },
          { "O", keys("?```.<CR>:nohl<CR><leader>kO<CR>pyc<C-e>"), { desc = "new cell ↑", exit = true } },
          { "r", ":QuartoSend<CR>", { desc = "run" } },
          { "R", ":QuartoSend<CR>:MoltenNext<CR>", { desc = "run" } },
          { "d", keys(")x"), { desc = "swap down" } },
          { "e", keys("(x"), { desc = "swap up" } },
          { "s", ":noautocmd MoltenEnterOutput<CR>", { desc = "show" } },
          { "h", ":MoltenHideOutput<CR>", { desc = "hide" } },
          { "a", ":QuartoSendAbove<CR>", { desc = "run above" } },
          { "<esc>", nil, { exit = true, desc = false } },
          { "q", nil, { exit = true, desc = false } },
        },
      })
      local nn = require("notebook-navigator")
      Hydra({
        name = "OtherNotebooks",
        hint = ""
          .. "_j_/_k_: ↓/↑ | _o_/_O_: new cell ↓/↑ | _d_/_e_: swap ↓/↑"
          .. string.char(10)
          .. "_r_un      | _R_un and move      | _s_how/_h_ide",
        config = {
          color = "pink",
          invoke_on_body = true,
          hint = {
            float_opts = {
              border = "rounded", -- you can change the border if you want
            },
          },
        },
        mode = { "n" },
        body = "<leader>hn",
        heads = {
          { "j", keys("]x"), { desc = "↓" } },
          { "k", keys("[x"), { desc = "↑" } },
          {
            "o",
            function()
              nn.add_cell_below()
            end,
            { desc = "new cell ↓", exit = true },
          },
          {
            "O",
            function()
              nn.add_cell_above()
            end,
            { desc = "new cell ↑", exit = true },
          },
          {
            "r",
            function()
              nn.run_cell()
            end,
            { desc = "run" },
          },
          {
            "R",
            function()
              nn.run_and_move()
            end,
            { des = "run and move" },
          },
          {
            "d",
            function()
              nn.swap_cell("d")
            end,
            { desc = "swap down" },
          },
          {
            "e",
            function()
              nn.swap_cell("u")
            end,
            { desc = "swap up" },
          },
          { "s", ":noautocmd MoltenEnterOutput<CR>", { desc = "show" } },
          { "h", ":MoltenHideOutput<CR>", { desc = "hide" } },
          { "<esc>", nil, { exit = true, desc = false } },
          { "q", nil, { exit = true, desc = false } },
        },
      })

      -- change the configuration when editing a python file
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*.py",
        callback = function()
          vim.keymap.set("n", "<leader>h", keys("<leader>hn"), { silent = true })
        end,
      })
      -- Undo those config changes when we go back to a markdown or quarto file
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*.qmd", "*.md", "*.ipynb" },
        callback = function()
          vim.keymap.set("n", "<leader>h", keys("<leader>hr"), { silent = true })
        end,
      })
    end,
  },
}
