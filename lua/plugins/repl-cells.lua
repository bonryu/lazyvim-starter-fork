return {
  {
    "benlubas/molten-nvim",
    -- version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- these are examples, not defaults. Please see the readme
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
    end,
    keys = {
      {
        "<leader>mi",
        function()
          local venv = os.getenv("CONDA_PREFIX")
          if venv ~= nil then
            -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
            venv = string.match(venv, "/.+/(.+)")
            vim.cmd(("MoltenInit %s"):format(venv))
          else
            vim.cmd({ "MoltenInit python3" })
          end
        end,
        desc = "Initialize Molten for python3",
      },
      { "<leader>mo", "<cmd>MoltenEvaluateOperator<CR>", silent = true, desc = "run operator selection" },
      { "<leader>ml", "<cmd>MoltenEvaluateLine<CR>", silent = true, desc = "evaluate line" },
      { "<leader>mr", "<cmd>MoltenReevaluateCell<CR>", silent = true, desc = "re-evaluate cell" },
      {
        "<leader>mv",
        ":<C-u>MoltenEvaluateVisual<CR>gv",
        mode = "v",
        silent = true,
        desc = "evaluate visual selection",
      },
      { "<localleader>md", ":MoltenDelete<CR>", silent = true, desc = "molten delete cell" },
      { "<localleader>mh", ":MoltenHideOutput<CR>", silent = true, desc = "hide output" },
      { "<localleader>ms", ":noautocmd MoltenEnterOutput<CR>", silent = true, desc = "show/enter output" },
    },
  },

  {
    "hanschen/vim-ipython-cell",
    init = function()
      vim.g.ipython_cell_highlight_cells = 0
      vim.g.ipython_cell_insert_tag = "# %%"
    end,
    fts = { "python", "markdown", "quarto" },
    keys = {
      { "<leader>je", ":IPythonCellExecuteCellJump<CR>", desc = "Execute cell and go to next cell" },
      { "<leader>js", ":SlimeSend1 ipython --matplotlib<CR>", desc = "start IPython with slime" },
      { "<leader>jr", ":IPythonCellRun<CR>", desc = "run the script" },
      { "<leader>jT", ":IPythonCellRunTime<CR>", desc = "Execute script and time it" },
      { "<leader>jl", ":IPythonCellClear<CR>", desc = "Clear IPython screen" },
      { "<leader>jx", ":IPythonCellClose<CR>", desc = "Close all Matplotlib figure windows" },
      { "<leader>jn", ":IPythonCellNextCell<CR>", silent = true, desc = "next cell" },
      { "<leader>jN", ":IPythonCellPrevCell<CR>", silent = true, desc = "prev cell" },
      { "]<Space>", ":IPythonCellNextCell<CR>", mode = { "n", "v" }, silent = true, desc = "next cell" },
      { "[<Space>", ":IPythonCellPrevCell<CR>", silent = true, desc = "prev cell" },
      { "<leader>jp", ":IPythonCellPrevCommand<CR>", desc = "prev command" },
      { "<leader>ja", ":IPythonCellInsertAbove<CR>lxjx", silent = true, desc = "Insert above" },
      { "<leader>jb", ":IPythonCellInsertBelow<CR>j", silent = true, desc = "Insert below" },
      { "<leader>jR", ":IPythonCellRestart<CR>", desc = "Restart IPython" },
      { "<leader>jd", ":SlimeSend1 %debug", desc = "start debug mode" },
      { "<leader>jq", ":SlimeSend1 exit<CR>", desc = "exit debug mode or IPython" },
    },
  },
}
