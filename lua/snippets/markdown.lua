if true then
  return {}
end
return {
  {
    "L3MON4D3/LuaSnip",
    config = function(_, opts)
      local ls = require("luasnip")
      ls.setup(opts)
      -- some shorthands...
      local s = ls.snippet
      local sn = ls.snippet_node
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node
      local c = ls.choice_node
      local d = ls.dynamic_node
      local r = ls.restore_node
      local l = require("luasnip.extras").lambda
      local rep = require("luasnip.extras").rep
      local p = require("luasnip.extras").partial
      local m = require("luasnip.extras").match
      local n = require("luasnip.extras").nonempty
      local dl = require("luasnip.extras").dynamic_lambda
      local fmt = require("luasnip.extras.fmt").fmt
      local fmta = require("luasnip.extras.fmt").fmta
      local types = require("luasnip.util.types")
      local conds = require("luasnip.extras.conditions")
      local conds_expand = require("luasnip.extras.conditions.expand")
      -- ls.add_snippets("quarto", {
      -- return {
      -- markdown = {
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
      -- }
    end,
  },
}
