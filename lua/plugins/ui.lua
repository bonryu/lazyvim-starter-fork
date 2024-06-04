-- if true then
--   return {}
-- end
-- vim.cmd([[highlight Headline1 guibg=#1e2718]])
-- vim.cmd([[highlight Headline2 guibg=#21262d]])
-- vim.cmd([[highlight CodeBlock guibg=#1c1c1c]])
-- vim.cmd([[highlight Dash guibg=#D19A66 gui=bold]])
return {
  {
    "lukas-reineke/headlines.nvim",
    -- solution found on reddit: https://www.reddit.com/r/neovim/comments/14m6ch6/how_to_change_the_background_color_of_code_blocks/
    -- https://github.com/hopezh/oatLazyVim/blob/headlines/lua/plugins/headlines.lua
    lazy = false,
    dependencies = "nvim-treesitter/nvim-treesitter",
    -- config = true,
    config = function()
      require("headlines").setup({
        quarto = {
          query = vim.treesitter.query.parse(
            "markdown",
            [[
                (atx_heading [
                    (atx_h1_marker)
                    (atx_h2_marker)
                    (atx_h3_marker)
                    (atx_h4_marker)
                    (atx_h5_marker)
                    (atx_h6_marker)
                ] @headline)

                (thematic_break) @dash

                (fenced_code_block) @codeblock

                (block_quote_marker) @quote
                (block_quote (paragraph (inline (block_continuation) @quote)))
                (block_quote (paragraph (block_continuation) @quote))
                (block_quote (block_continuation) @quote)
            ]]
          ),
          headline_highlights = { "Headline" },
          treesitter_language = "markdown",
          -- headline_highlights = {
          --   "Headline1",
          --   "Headline2",
          --   "Headline3",
          -- },
          bullet_highlights = {
            "@text.title.1.marker.markdown",
            "@text.title.2.marker.markdown",
            "@text.title.3.marker.markdown",
            "@text.title.4.marker.markdown",
            "@text.title.5.marker.markdown",
            "@text.title.6.marker.markdown",
          },
          bullets = { "◉", "○", "✸", "✿" },
          codeblock_highlight = "CodeBlock",
          dash_highlight = "Dash",
          dash_string = "-",
          quote_highlight = "Quote",
          quote_string = "┃",
          fat_headlines = true,
          fat_headline_upper_string = "▃",
          fat_headline_lower_string = "🬂",
        },
        -- quarto = {
        --   --   query = vim.treesitter.query.parse(
        --   --     "markdown",
        --   --     [[
        --   --         (fenced_code_block) @codeblock
        --   --     ]]
        --   --   ),
        --   --   codeblock_highlight = "CodeBlock",
        --   --   treesitter_language = "markdown",
        --   -- },
        --   query = vim.treesitter.query.parse(
        --     "markdown",
        --     [[
        --                 (atx_heading [
        --                     (atx_h1_marker)
        --                     (atx_h2_marker)
        --                     (atx_h3_marker)
        --                     (atx_h4_marker)
        --                     (atx_h5_marker)
        --                     (atx_h6_marker)
        --                 ] @headline)
        --
        --                 (thematic_break) @dash
        --
        --                 (fenced_code_block) @codeblock
        --
        --                 (block_quote_marker) @quote
        --                 (block_quote (paragraph (inline (block_continuation) @quote)))
        --             ]]
        --   ),
        --
        --   treesitter_language = "markdown",
        --   headline_highlights = {
        --     "Headline1",
        --     "Headline2",
        --     "Headline3",
        --   },
        --   codeblock_highlight = "CodeBlock",
        --   dash_highlight = "Dash",
        --   dash_string = "-",
        --   quote_highlight = "Quote",
        --   quote_string = "┃",
        --   fat_headlines = true,
        --   fat_headline_upper_string = "-",
        --   fat_headline_lower_string = "",
        -- },
        -- python = {
        --   query = vim.treesitter.query.parse(
        --     "python",
        --     [[
        --         (
        --             (comment) @dash
        --             (#match? @dash "^\\# \\%\\%")
        --         )
        --     ]]
        --   ),
        --   treesitter_language = "python",
        --   headline_highlights = { "Headline" },
        --   dash_highlight = "Dash",
        --   dash_string = "-",
        -- },
      })
    end,
  },
}
