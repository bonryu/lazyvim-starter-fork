if true then
  return {}
end
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
      -- run
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
            return qrunner.run_cell()
            -- return ":QuartoSend<CR>" -- Works!!
            -- return ":lua require'quarto'.runner.QuartoSend<cr>:MoltenNext<CR>"  -- Works!!
            -- { "r", ":QuartoSend<CR>" },
          end
        end
      end
      -- run and move
      local function run_and_move()
        return function()
          if vim.bo.filetype == "python" then
            notify("filetype is: " .. vim.bo.filetype)
            return nn.run_and_move()
          elseif vim.bo.filetype == "quarto" then
            notify("filetype is: " .. vim.bo.filetype)
            -- return ":QuartoSend<CR>:MoltenNext<CR>"
            keys2("<cmd>MoltenNext<CR>")
          end
        end
      end
      -- add cell before
      local function add_cell_before()
        return function()
          if vim.bo.filetype == "quarto" then
            notify("filetype is: " .. vim.bo.filetype)
            -- return "[l" -- keys2("[l")
            -- local timer = vim.uv.new_timer()
            -- timer:start(100, 0, vim.schedule_wrap(keys("]l")))
            -- timer:start(300, 0, vim.schedule_wrap(keys("[l")))

            -- keys("[l")
            -- return ":<esc>kOasdf"
            --
            -- "TSTextobjectGotoPreviousStart"
            -- local tso = require("nvim-treesitter.ts_utils")
            -- return ":TSTextobjectGotoNextStart(l)<CR>" -- <CR>kOasdf"
            -- keys("<cmd>TSTextobjectGotoNextEnd(l)<CR><cmd>TSTextobjectGotoPreviousStart(l)<CR>") -- <CR>kOasdf"
            -- keys("<cmd>TSTextobjectGotoNextEnd(l)<CR>") -- <CR>kOasdf" doesn't  work
            --
            --
            -- keys2("\\<cmd>TSTextobjectGotoNextEnd(l)\\<CR>\\<cmd>TSTextobjectGotoPreviousStart(l)\\<CR>")
            -- keys2("\<cmd>TSTextobjectGotoNextEnd(l)\<CR><cmd>TSTextobjectGotoPreviousStart(l)<CR>")
            -- return "<cmd>TSTextobjectGotoNextEnd(l)<CR><cmd>TSTextobjectGotoPreviousStart(l)<CR>" -- <CR>kOasdf"
            return ":MoltenNext<CR>"
            -- keys2(":MoltenNext<CR>:MoltenPrev<CR>")
          end
        end
      end

      local Hydra = require("hydra")
      Hydra({
        name = "QuartoNavigator",
        hint = hint,
        config = {
          color = "pink",
          invoke_on_body = true,
          hint = {
            border = "rounded", -- you can change the border if you want
          },
        },
        mode = { "n" },
        body = "<leader>hr", -- this is the key that triggers the hydra
        heads = {
          -- comment = "c", run = "X", run_and_move = "x", move_up = "k", move_down = "j", add_cell_before = "a", "add_cell_after" = "b"
          { "j", keys("]l"), { desc = "move down" } },
          { "k", keys("[l"), { desc = "move " } },
          { "r", run(), { desc = "run" } },
          -- { "r", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
          -- { "r", ":QuartoSend<CR>" },
          { "l", ":QuartoSendLine<CR>" },
          {
            "a",
            keys2("<cmd>MoltenNext<CR>"),
            -- function()
            --   keys("<cmd>MoltenNext<CR>")
            -- end,
            { desc = "add cell before", silent = false },
          },
          -- {
          --   "a",
          --   "<cmd>TSTextobjectGotoNextEnd(l)<CR><cmd>TSTextobjectGotoPreviousStart(l)<CR>",
          --   { desc = "add cell before", silent = false },
          -- },
          { "R", run_and_move(), { desc = "run and move down" } },
          -- { "R", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
          { "<esc>", nil, { exit = true } },
          { "q", nil, { exit = true } },
        },
      })
    end,
  },
}
