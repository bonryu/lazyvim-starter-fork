return {
  {
    "folke/tokyonight.nvim",

    opts = {
      on_highlights = function(hl, c)
        hl.WinBar = {
          bg = "#2f334d",
          bold = 1,
          italic = 1,
        }
        hl.WinBarNC = {
          default = 1,
        }
      end,
    },
  },
}
