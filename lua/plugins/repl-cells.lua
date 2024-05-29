return {

  {
    "hanschen/vim-ipython-cell",
    init = function()
      vim.g.ipython_cell_highlight_cells = 0
      vim.g.ipython_cell_insert_tag = "# %%"
    end,
    ft = { "python" },
    keys = {
      { "<leader>je", ":IPythonCellExecuteCellJump<CR>", desc = "Execute cell and go to next cell" },
      { "<leader>js", ":SlimeSend1 ipython --matplotlib<CR>", desc = "start IPython with slime" },
      { "<leader>jr", ":IPythonCellRun<CR>", desc = "run the script" },
      { "<leader>jT", ":IPythonCellRunTime<CR>", desc = "Execute script and time it" },
      { "<leader>jl", ":IPythonCellClear<CR>", desc = "Clear IPython screen" },
      { "<leader>jx", ":IPythonCellClose<CR>", desc = "Close all Matplotlib figure windows" },
      { "<leader>jn", ":IPythonCellNextCell<CR>", silent = true, desc = "next cell" },
      { "<leader>jN", ":IPythonCellPrevCell<CR>", silent = true, desc = "prev cell" },
      { "]<Space>", ":IPythonCellNextCell<CR>", mode = { "n", "v" }, silent = true, desc = "IPythonCell next cell" },
      { "[<Space>", ":IPythonCellPrevCell<CR>", silent = true, desc = "IPythonCell prev cell" },
      { "<leader>jp", ":IPythonCellPrevCommand<CR>", desc = "prev command" },
      { "<leader>ja", ":IPythonCellInsertAbove<CR>lxjx", silent = true, desc = "Insert above" },
      { "<leader>jb", ":IPythonCellInsertBelow<CR>j", silent = true, desc = "Insert below" },
      { "<leader>jR", ":IPythonCellRestart<CR>", desc = "Restart IPython" },
      { "<leader>jd", ":SlimeSend1 %debug", desc = "start debug mode" },
      { "<leader>jq", ":SlimeSend1 exit<CR>", desc = "exit debug mode or IPython" },
    },
  },
}
