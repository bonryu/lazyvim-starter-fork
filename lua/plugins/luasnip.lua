return {
  {
    "L3MON4D3/LuaSnip",
    config = function(_, opts)
      local ls = require("luasnip")
      ls.setup(opts)
      vim.keymap.set({ "i", "s" }, "<C-e>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, { silent = true, desc = "expand snippet or jump to the next snippet node" })
    end,
  },
}
