return {
  {
    -- By Bon. prevent replaceing ``` with ````
    "nvim-mini/mini.pairs",
    event = "VeryLazy",
    config = function()
      require("mini.pairs").setup()
      MiniPairs.unmap("i", "`", "``")
      MiniPairs.map(
        "i",
        "`",
        { action = "closeopen", pair = "``", neigh_pattern = "[^\\`{2}].", register = { cr = false } }
      )
    end,
  },
}
