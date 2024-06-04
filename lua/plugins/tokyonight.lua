return {
  {
    "folke/tokyonight.nvim",

    opts = {
      on_highlights = function(hl, c)
        hl.WinBar = {
          -- "#7c85cc" 20%
          -- "#6d74b3" 30%
          -- "#4e5480" 50%
          -- "#3e4366" 60%
          -- "#363b59" 65%
          -- "#2f324d" 70%
          -- "#101119" 90%
          -- "#2f334d" current line
          -- "#848fd9" current line 15%
          -- "#9ca8ff" current line 0%
          bg = "#3e4366",
          bold = 1,
          italic = 1,
        }
        hl.WinBarNC = {
          bg = "#2f324d",
          fg = "#9ca8ff",
        }
      end,
    },
  },
}
