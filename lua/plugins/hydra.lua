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
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(str, true, false, true), "m", true)
        end
      end
      local function run()
        return function()
          if vim.bo.filetype == "python" then
            notify("filetype is: " .. vim.bo.filetype)
            return nn.run_cell()
            -- return "<cmd>lua require('notebook-navigator').run_cell()<cr>" -- doesn't work
          elseif vim.bo.filetype == "quarto" then
            notify("filetype is: " .. vim.bo.filetype)
            -- qrunner.run_cell()  -- does the same thing  as return qrunner.run_cell()
            -- qrunner.run_below()
            -- return qrunner.run_cell()
            return ":QuartoSend<CR>" -- Works!!
            -- return ":lua require'quarto'.runner.QuartoSend<cr>:MoltenNext<CR>"  -- Works!!
            -- { "r", ":QuartoSend<CR>" },
          end
        end
      end
      local function run_and_move()
        return function()
          if vim.bo.filetype == "python" then
            notify("filetype is: " .. vim.bo.filetype)
            return nn.run_and_move()
          elseif vim.bo.filetype == "quarto" then
            notify("filetype is: " .. vim.bo.filetype)
            return ":QuartoSend<CR>:MoltenNext<CR>"
          end
        end
      end
      local Hydra = require("hydra")
      Hydra({
        name = "Navigator",
        hint = hint,
        config = {
          color = "pink",
          invoke_on_body = true,
          hint = {
            border = "rounded", -- you can change the border if you want
          },
        },
        mode = { "n" },
        body = "<leader>h", -- this is the key that triggers the hydra
        heads = {
          -- comment = "c", run = "X", run_and_move = "x", move_up = "k", move_down = "j", add_cell_before = "a", "add_cell_after" = "b"
          { "j", keys("]l"), { desc = "move down" } },
          { "k", keys("[l"), { desc = "move " } },
          { "r", run(), { desc = "run" } },
          -- { "r", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
          -- { "r", ":QuartoSend<CR>" },
          { "l", ":QuartoSendLine<CR>" },
          { "R", run_and_move(), { desc = "run and move down" } },
          -- { "R", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
          { "<esc>", nil, { exit = true } },
          { "q", nil, { exit = true } },
        },
      })
    end,
  },
}
