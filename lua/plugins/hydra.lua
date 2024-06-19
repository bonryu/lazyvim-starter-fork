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
      local notify = require("notify")
      local quarto = require("quarto")
      local qrunner = require("quarto.runner")
      local nn = require("notebook-navigator")
      local function keys(str)
        return function()
          --  "m" means remap keys
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(str, true, false, true), "m", true)
        end
      end
      local function keys2(str)
        return function()
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(str, true, false, true), "n", true)
        end
      end

      local Hydra = require("hydra")
      Hydra({
        name = "QuartoNotebook",
        hint = "_j_/_k_: ↑/↓ | _o_/_O_: new cell ↓/↑ | _r_: run | _s_how/_h_ide | run _a_bove",
        config = {
          color = "pink",
          invoke_on_body = true,
          hint = {
            border = "rounded", -- you can change the border if you want
          },
        },
        mode = { "n" },
        body = "<leader>hr",
        heads = {
          { "j", keys("]l"), { desc = "↓" } },
          { "k", keys("[l"), { desc = "↑" } },
          { "o", keys("/```<CR>:nohl<CR>o<CR>pyc<C-e>"), { desc = "new cell ↓", exit = true } },
          { "O", keys("?```.<CR>:nohl<CR><leader>kO<CR>pyc<C-e>"), { desc = "new cell ↑", exit = true } },
          { "r", ":QuartoSend<CR>", { desc = "run" } },
          { "s", ":noautocmd MoltenEnterOutput<CR>", { desc = "show" } },
          { "h", ":MoltenHideOutput<CR>", { desc = "hide" } },
          { "a", ":QuartoSendAbove<CR>", { desc = "run above" } },
          { "<esc>", nil, { exit = true, desc = false } },
          { "q", nil, { exit = true, desc = false } },
        },
      })
    end,
  },
}
