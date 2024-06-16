if true then
  return {}
end
return {
  {
    "L3MON4D3/LuaSnip",
    -- opts = {
    --   autosnippets = true,
    -- },
    config = function(_, opts)
      table.insert(opts, { autosnippets = true })
      local ls = require("luasnip")
      ls.config.setup(opts)
      require("luasnip.loaders.from_lua").load({ paths = { vim.fn.stdpath("config") .. "/lua/snippets" } })
      -- some shorthands...

      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local c = ls.choice_node
      local fmta = require("luasnip.extras.fmt").fmta
      ls.add_snippets("all", {
        -- code cell
        s(
          "```",
          -- {
          --   trig = "```",
          --   -- trig = "^%s*```",
          --   regTrig = true,
          --   -- trigEngine = "pattern",
          -- },
          fmta(
            [[```<lang>
<last>
``]],
            {
              lang = c(1, { t("python"), t("lua"), t("") }),
              last = i(0),
            }
          )
        ),
      })
    end,
  },
}
