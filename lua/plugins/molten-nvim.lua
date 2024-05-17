return {
  {
    "benlubas/molten-nvim",
    -- version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- these are examples, not defaults. Please see the readme
      -- vim.g.molten_auto_open_output = true
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_wrap_output = true
      -- vim.g.molten_virt_text_output = true
      -- vim.g.molten_output_virt_lines = true
      vim.g.molten_virt_lines_off_by_1 = false
      -- vim.g.molten_output_win_border = { "", "", "", "" }
      -- vim.g.molten_output_win_border = { "", "-", "", "", "", "_", "", "" }
      -- vim.g.molten_output_win_style = "minimal"
      vim.g.molten_output_win_hide_on_leave = true
      vim.g.molten_output_win_cover_gutter = false
      -- vim.g.molten_cover_empty_lines = false
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
      -- "At minimum you should setup:"
      { "<leader>mo", ":MoltenEvaluateOperator<CR>", silent = true, desc = "run operator selection" },
      { "<leader>ms", ":noautocmd MoltenEnterOutput<CR>", silent = true, desc = "show/enter output" },
      -- The following are also recommended
      { "<leader>mr", "<cmd>MoltenReevaluateCell<CR>", silent = true, desc = "re-evaluate cell" },
      {
        "<leader>mv",
        ":<C-u>MoltenEvaluateVisual<CR>gv",
        mode = "v",
        silent = true,
        desc = "evaluate visual selection",
      },
      { "<leader>ml", ":MoltenEvaluateLine<CR>", silent = true, desc = "evaluate line" },
      { "<leader>mh", ":MoltenHideOutput<CR>", silent = true, desc = "hide output" },
      { "<leader>md", ":MoltenDelete<CR>", silent = true, desc = "molten delete cell" },
      -- if you work with html outputs:
      { "<leader>mx", ":MoltenOpenInBrowser<CR>", silent = true, desc = "open output in browser" },
    },
  },
}
