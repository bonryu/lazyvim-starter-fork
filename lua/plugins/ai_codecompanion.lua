-- lazy.nvim
return {
  {
    "olimorris/codecompanion.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp", -- Optional: For autocompletion
      "nvim-telescope/telescope.nvim", -- Optional: For searching
      { "stevearc/dressing.nvim", opts = {} }, -- Optional: Better UI
    },
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "AI Chat", mode = { "n", "v" } },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "AI Actions", mode = { "n", "v" } },
      { "<leader>ae", "<cmd>CodeCompanion<cr>", desc = "AI Inline Edit", mode = { "n", "v" } },
      -- Useful for adding selected code to the chat
      { "<leader>aC", "<cmd>CodeCompanionChat Add<cr>", desc = "AI Add to Chat", mode = "v" },
    },
    opts = {
      opts = {
        log_level = "DEBUG",
      },
    },
    config = function()
      require("codecompanion").setup({
        interactions = {
          chat = {
            adapter = {
              name = "gemini",
              model = "gemini-2.5-flash",
            },
          },
          inline = {
            adapter = {
              name = "gemini",
              model = "gemini-2.5-flash-lite",
            },
          },
          agent = {
            adapter = {
              name = "gemini",
              model = "gemini-2.5-flash",
            },
          },
        },

        adapters = {
          http = {
            gemini = function()
              return require("codecompanion.adapters").extend("gemini", {
                env = {
                  api_key = _G.br.read_secret("default_gemini_api_key"), -- Or use os.getenv("GEMINI_API_KEY")
                },
                -- schema = {
                --   model = {
                --     default = "gemini-2.0-flash", -- Fast and very capable for coding
                --   },
                -- },
              })
            end,
          },
          -- claude = function()
          --   return require("codecompanion.adapters").extend("anthropic", {
          --     env = {
          --       api_key = "YOUR_ANTHROPIC_API_KEY",
          --     },
          --     schema = {
          --       model = {
          --         default = "claude-3-5-sonnet-latest",
          --       },
          --     },
          --   })
          -- end,
        },
      })
    end,
  },
}
