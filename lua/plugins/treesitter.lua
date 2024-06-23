return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- -- Can't seem to make a which key prefix "<leader>ms"
    -- init = function()
    --   require("which-key").register({
    --     ["<leader>ms"] = {
    --       name = "+molten swaps",
    --     },
    --   })
    -- end,
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "css",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "julia",
        "latex",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "r",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      -- below is from quarto
      highlight = {
        enabled = true,
        additional_vim_regex_highlighting = false,
      },

      textobjects = {
        move = {
          enable = true,
          set_jumps = false, -- you can change this if you want.
          goto_next_start = {
            --- ... other keymaps
            ["]x"] = { query = "@code_cell.inner", desc = "next code cell start" },
          },
          goto_previous_start = {
            --- ... other keymaps
            ["[x"] = { query = "@code_cell.inner", desc = "previous code cell start" },
          },
          goto_next_end = {
            --- ... other keymaps
            ["]X"] = { query = "@code_cell.inner", desc = "next code cell end" },
          },
          goto_previous_end = {
            --- ... other keymaps
            ["[X"] = { query = "@code_cell.inner", desc = "previous code cell end" },
          },
        },
        select = {
          enable = true,
          lookahead = true, -- you can change this if you want
          keymaps = {
            --- ... other keymaps
            ["ix"] = { query = "@code_cell.inner", desc = "in cell" },
            ["ax"] = { query = "@code_cell.outer", desc = "around cell" },
          },
        },
        swap = { -- Swap only works with code blocks that are under the same
          -- markdown header
          enable = true,
          swap_next = {
            [")m"] = "@function.outer",
            [")c"] = "@comment.outer",
            [")a"] = "@parameter.inner",
            [")b"] = "@block.outer",
            [")C"] = "@class.outer",
            [")x"] = "@code_cell.outer",
          },
          swap_previous = {
            ["(m"] = "@function.outer",
            ["(c"] = "@comment.outer",
            ["(a"] = "@parameter.inner",
            ["(b"] = "@block.outer",
            ["(C"] = "@class.outer",
            ["(x"] = "@code_cell.outer",
          },
          -- swap_next = {
          --   --- ... other keymap
          --   ["<leader>mj"] = { "@code_cell.outer", desc = "swap with next" },
          -- },
          -- swap_previous = {
          --   --- ... other keymap
          --   ["<leader>mk"] = { "@code_cell.outer", desc = "swap with previous" },
          -- },
        },
      },
    },
    -- -- Can't seem to make a which key prefix "<leader>ms"
    -- config = function(_, opts)
    --   local treesitter = require("nvim-treesitter.configs")
    --   treesitter.setup(opts)
    --   require("which-key").register({
    --     ["<leader>ms"] = {
    --       name = "+molten swaps",
    --     },
    --   })
    -- end,
  },
  -- below is probably not needed.
  -- { "nvim-treesitter/nvim-treesitter-textobjects" },
}
