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
      vim.g.molten_wrap_output = true
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
}
