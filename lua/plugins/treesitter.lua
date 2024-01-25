return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "css",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "julia",
        "latex",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "r",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      -- below is from quarto
      highlight = {
        enabled = true,
        additional_vim_regex_highlighting = false,
      },
    },
  },
  -- below is probably not needed.
  -- { "nvim-treesitter/nvim-treesitter-textobjects" },
}
