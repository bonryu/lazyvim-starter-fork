return {
  {
    "mfussenegger/nvim-dap",

    dependencies = {
      -- fancy UI for the debugger
      "rcarriga/nvim-dap-ui",
      -- stylua: ignore
      keys = {
        { "<leader>dr", function() require("dapui").open({reset = true }) end, desc = "ui reset", mode = {"n"} },
      },
    },
    keys = {
      -- {
      --   "<leader>dB",
      --   function()
      --     require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      --   end,
      --   desc = "Breakpoint Condition",
      -- },
      -- {
      --   "<leader>db",
      --   function()
      --     require("dap").toggle_breakpoint()
      --   end,
      --   desc = "Toggle Breakpoint",
      -- },
      {
        "<F5>", -- "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      -- {
      --   "<leader>da",
      --   function()
      --     require("dap").continue({ before = get_args })
      --   end,
      --   desc = "Run with Args",
      -- },
      -- {
      --   "<leader>dC",
      --   function()
      --     require("dap").run_to_cursor()
      --   end,
      --   desc = "Run to Cursor",
      -- },
      -- {
      --   "<leader>dg",
      --   function()
      --     require("dap").goto_()
      --   end,
      --   desc = "Go to line (no execute)",
      -- },
      {
        "<F11>", -- "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      -- {
      --   "<leader>dj",
      --   function()
      --     require("dap").down()
      --   end,
      --   desc = "Down",
      -- },
      -- {
      --   "<leader>dk",
      --   function()
      --     require("dap").up()
      --   end,
      --   desc = "Up",
      -- },
      {
        "<S-F11>", -- "<leader>do",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<F10>", -- "<leader>dO",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      -- {
      --   "<leader>dp",
      --   function()
      --     require("dap").pause()
      --   end,
      --   desc = "dap Pause",
      -- },
      {
        "<S-F5>", -- "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "dap Terminate",
      },
      {
        "<leader>dR", -- "<leader>dt",
        function()
          require("dap").terminate()
          require("dap").continue()
        end,
        desc = "dap restart",
      },
      {
        "<leader>dw",
        function()
          require("dap.ui.widgets").hover()
        end,
        desc = "Widgets",
      },
    },
  },
}
