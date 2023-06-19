return {
  -- register the gruvbox theme
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  -- This lua table updates the definition of LazyVim
  -- and adjusts the colorsheme to be gruvbox instead of the default tokyonight
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}

-- when we save this file, LazyVim already detects this file as special
-- open Lazy.nvim and it will show that we should install gruvbox
