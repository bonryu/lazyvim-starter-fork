return {
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim", -- Required for automatic moves in Neo-tree
    },
    config = true, -- This is shorthand for below
    -- config = function()
    --   require("lsp-file-operations").setup()
    -- end,
  },
}
