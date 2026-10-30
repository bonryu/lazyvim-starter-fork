local HOME = os.getenv("HOME")
return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint-cli2" },
      },
      linters = {
        ["markdownlint-cli2"] = {
          args = {
            "--config",
            HOME .. "/.markdownlint-cli2.yaml",
            "--", -- End of options
            "$FILENAME", -- Explicitly pass the current file to lint
          },
        },
      },
    },
  },
  {
    url = "https://github.com/bonryu/render-markdown.nvim.git",
    branch = "feature/slimmertable",
    opts = {
      -- Table options, set to the plugin's defaults except cell (LazyVim and avante set none of them).
      -- Source: render-markdown.nvim lua/render-markdown/settings.lua, M.pipe_table.default.
      -- Not listed, left at their defaults:
      --   wrap = true          : wrap text inside cells to keep tables within the window
      --   max_table_width = 0  : "fit" only, a table width limit below the window (0 = no limit)
      pipe_table = {
        -- Columns to keep free between wrapped tables and the right edge of the window.
        right_margin = 2, -- integer >= 0
        -- Turn table rendering on / off.
        enabled = true, -- true | false
        -- Extra modes to render tables in, beyond the global render_modes.
        render_modes = false, -- false | true (all modes) | { "n", "c", "t", "i", ... }
        -- Preset border characters.
        preset = "none", -- "none" | "round" | "double" | "heavy"
        -- How cells are drawn:
        --   "padded"  : borders + cells padded to the widest cell in each column
        --   "trimmed" : padded, but trailing blank space doesn't count toward the width
        --   "raw"     : only the '|' characters are replaced; cells keep their written width
        --   "overlay" : draws over the whole table; no conceal or highlights in the cells
        --   "fit"     : trimmed, but long columns share the window by length and wrap between words
        cell = "fit", -- "padded" | "trimmed" | "raw" | "overlay" | "fit"
        -- Adjust each cell's computed width; ctx.node is the cell's treesitter node.
        cell_offset = function(ctx) -- fun(ctx): integer
          return 0
        end,
        -- Spaces between cell contents and border.
        padding = 1, -- integer >= 0
        -- Minimum column width for "padded" / "trimmed" / "fit".
        min_width = 0, -- integer >= 0
        -- Border characters: top(3), delimiter(3), bottom(3), vertical, horizontal.
        -- stylua: ignore
        border = {
          "┌", "┬", "┐",
          "├", "┼", "┤",
          "└", "┴", "┘",
          "│", "─",
        },
        -- Draw the top and bottom border lines.
        border_enabled = true, -- true | false
        -- Always draw the top/bottom borders as virtual lines instead of using empty lines.
        -- Turned on automatically when the indent module is enabled.
        border_virtual = false, -- true | false
        -- Draw a line between body rows, using the delimiter border characters.
        row_borders = true, -- true | false
        -- Marker placed in the delimiter row, positioned by column alignment.
        alignment_indicator = "━", -- any single-width string
        -- Highlight group for the header, the delimiter row, and the line above.
        head = "RenderMarkdownTableHead", -- any highlight group name
        -- Highlight group for the body rows and the line below.
        row = "RenderMarkdownTableRow", -- any highlight group name
        -- Shorthand for the whole table:
        --   "full"   : all of the values above
        --   "normal" : as border_enabled = false
        --   "none"   : as enabled = false
        style = "full", -- "full" | "normal" | "none"
      },
    },
  },
}
-- local HOME = os.getenv("HOME")
-- return {
--   {
--     "mfussenegger/nvim-lint",
--     optional = true,
--     opts = {
--       linters_by_ft = {
--         markdown = { "markdownlint-cli2" },
--       },
--       linters = {
--         ["markdownlint-cli2"] = {
--           args = { "--config", HOME .. "/.markdownlint-cli2.yaml", "--" },
--         },
--       },
--     },
--   },
-- }
