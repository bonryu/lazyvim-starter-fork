return {
  {
    "stevearc/overseer.nvim",
    opts = {
      templates = { "builtin", "user.run_script" },
      task_list = {
        bindings = {
          ["?"] = "ShowHelp",
          ["g?"] = "ShowHelp",
          ["<CR>"] = "RunAction",
          ["<C-e>"] = "Edit",
          ["o"] = "Open",
          ["s"] = "OpenVsplit",
          ["S"] = "OpenSplit",
          ["<C-f>"] = "OpenFloat",
          ["<C-q>"] = "OpenQuickFix",
          ["P"] = "TogglePreview",
          ["L"] = "IncreaseDetail",
          ["H"] = "DecreaseDetail",
          ["zR"] = "IncreaseAllDetail",
          ["zM"] = "DecreaseAllDetail",
          ["<C-Left>"] = "DecreaseWidth",
          ["<C-Right>"] = "IncreaseWidth",
          ["{"] = "PrevTask",
          ["}"] = "NextTask",
          ["u"] = "ScrollOutputUp",
          ["i"] = "ScrollOutputDown",
          ["q"] = "Close",
        },
      },
    },
    keys = {
      { "<leader>vr", "<cmd>OverseerRun<cr>", desc = "OverseerRun" },
      { "<leader>vt", "<cmd>OverseerToggle<cr>", desc = "OverseerToggle" },
      { "<leader>v<cr>", "<cmd>OverseerQuickAction restart<cr>", desc = "OverseerQuickAction restart" },
    },
  },
}
