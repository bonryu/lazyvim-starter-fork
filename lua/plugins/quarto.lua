-- This is a config that can be merged with your
-- existing LazyVim config.
--
-- It configures all plugins necessary for quarto-nvim,
-- such as adding its code completion source to the
-- completion engine nvim-cmp.
-- Thus, instead of having to change your configuration entirely,
-- this takes your existings config and adds on top where necessary.

local wk = require("which-key")

wk.register({
  o = {
    name = "otter & code",
    a = { require("otter").dev_setup, "otter activate" },
    ["o"] = { "o# %%<cr>", "new code chunk below" },
    ["O"] = { "O# %%<cr>", "new code chunk above" },
    ["b"] = { "o```{bash}<cr>```<esc>O", "bash code chunk" },
    ["r"] = { "o```{r}<cr>```<esc>O", "r code chunk" },
    ["p"] = { "o```{python}<cr>```<esc>O", "python code chunk" },
    ["j"] = { "o```{julia}<cr>```<esc>O", "julia code chunk" },
  },
}, { mode = "n", prefix = "<leader>" })

return {

  -- this taps into vim.ui.select and vim.ui.input
  -- and in doing so currently breaks renaming in otter.nvim

  {
    "stevearc/dressing.nvim",
    enabled = false,
  },

  {
    "quarto-dev/quarto-nvim",
    opts = {
      lspFeatures = {
        languages = { "r", "python", "julia", "bash", "html", "lua" },
        chunks = "curly",
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
      },
      codeRunner = {
        enabled = false,
        default_method = nil, -- "molten" or "slime"
        ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
        -- Takes precedence over `default_method`
        never_run = { "yaml" }, -- filetypes which are never sent to a code runner
      },
      keymap = {
        hover = "K",
        definition = "gd",
        type_definition = "gD",
        rename = "<leader>rR",
        format = "<leader>rf",
        references = "gr",
        document_symbols = "gS",
      },
    },
    ft = "quarto",
    keys = {
      { "<leader>ra", ":QuartoActivate<cr>", desc = "quarto activate" },
      { "<leader>rp", ":lua require'quarto'.quartoPreview()<cr>", desc = "quarto preview" },
      { "<leader>rq", ":lua require'quarto'.quartoClosePreview()<cr>", desc = "quarto close" },
      { "<leader>rh", ":QuartoHelp ", desc = "quarto help" },
      { "<leader>re", ":lua require'otter'.export()<cr>", desc = "otter export" },
      { "<leader>rE", ":lua require'otter'.export(true)<cr>", desc = "otter export overwrite" },
      { "<leader>rsa", ":QuartoSendAbove<cr>", desc = "quarto send above" },
      { "<leader>rsr", ":QuartoSendAll<cr>", desc = "quarto run all" },

      -- normal mode
      { "<leader>i<cr>", ":SlimeSend<cr>", desc = "slime send <c-cr>" },
      { "<c-cr>", ":SlimeSend<cr>", desc = "slime send: <c-cr>" },
      { "<leader><cr>", "<Plug>SlimeSendCell<cr>", desc = "slime send cell" },

      -- insert mode
      { "<c-cr>", "<esc>:SlimeSend<cr>i", mode = "i", desc = "slime send: <c-cr>" },

      -- visual mode
      { "<leader>i<cr>", "<Plug>SlimeRegionSend<cr>", mode = "v", desc = "slime region send: <c-cr> or <cr>" },
      { "<c-cr>", "<Plug>SlimeRegionSend<cr>", mode = "v", desc = "send region send: <c-cr> or <cr>" },
      { "<cr>", "<Plug>SlimeRegionSend<cr>", mode = "v", desc = "send region send: <c-cr> or <cr>" },

      { "<leader>ic", ":SlimeConfig<cr>", desc = "slime config" },
      { "<leader>ir", ":split term://R<cr>", desc = "split terminal: R" },
      { "<leader>ii", ":split term://ipython<cr>", desc = "split terminal: ipython" },
      { "<leader>ip", ":split term://python<cr>", desc = "split terminal: python" },
      { "<leader>ij", ":split term://julia<cr>", desc = "split terminal: julia" },
      { "<leader>in", ":vsplit term://$SHELL<cr>", desc = "vsplit terminal: shell" },
      { "<leader>iN", ":vsplit term://$SHELL<cr>", desc = "split terminal: shell" },
      { "<leader>iR", ":vsplit term://R<cr>", desc = "vsplit terminal: R" },
      { "<leader>iP", ":vsplit term://python<cr>", desc = "vsplit terminal: python" },
      { "<leader>iI", ":vsplit term://ipython<cr>", desc = "vsplit termianl: ipython" },
      { "<leader>iJ", ":vsplit term://julia<cr>", desc = "vsplit termina: julia" },
    },
  },

  -- send code from python/r/qmd documets to a terminal or REPL
  -- like ipython, R, bash
  {
    "jpalardy/vim-slime",
    init = function()
      vim.b["quarto_is_" .. "python" .. "_chunk"] = false
      Quarto_is_in_python_chunk = function()
        require("otter.tools.functions").is_otter_language_context("python")
      end

      vim.cmd([[
      let g:slime_dispatch_ipython_pause = 100
      function SlimeOverride_EscapeText_quarto(text)
      call v:lua.Quarto_is_in_python_chunk()
      if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk
      return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
      else
      return a:text
      end
      endfunction
      ]])

      local function mark_terminal()
        vim.g.slime_last_channel = vim.b.terminal_job_id
        vim.print(vim.g.slime_last_channel)
      end

      local function set_terminal()
        vim.b.slime_config = { jobid = vim.g.slime_last_channel }
      end

      vim.b.slime_cell_delimiter = "# %%"

      -- slime, neovvim terminal
      vim.g.slime_target = "neovim"
      vim.g.slime_python_ipython = 1

      -- -- slime, tmux
      -- vim.g.slime_target = 'tmux'
      -- vim.g.slime_bracketed_paste = 1
      -- vim.g.slime_default_config = { socket_name = "default", target_pane = ".2" }

      local function toggle_slime_tmux_nvim()
        if vim.g.slime_target == "tmux" then
          pcall(function()
            vim.b.slime_config = nil
            vim.g.slime_default_config = nil
          end)
          -- slime, neovvim terminal
          vim.g.slime_target = "neovim"
          vim.g.slime_bracketed_paste = 0
          vim.g.slime_python_ipython = 1
        elseif vim.g.slime_target == "neovim" then
          pcall(function()
            vim.b.slime_config = nil
            vim.g.slime_default_config = nil
          end)
          -- -- slime, tmux
          vim.g.slime_target = "tmux"
          vim.g.slime_bracketed_paste = 1
          vim.g.slime_default_config = { socket_name = "default", target_pane = ".2" }
        end
      end

      require("which-key").register({
        ["<leader>im"] = { mark_terminal, "mark terminal" },
        ["<leader>is"] = { set_terminal, "set terminal" },
        ["<leader>it"] = { toggle_slime_tmux_nvim, "toggle tmux/nvim terminal" },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        pyright = {},
        r_language_server = {},
        julials = {},
        marksman = {
          -- also needs:
          -- $home/.config/marksman/config.toml :
          -- [core]
          -- markdown.file_extensions = ["md", "markdown", "qmd"]
          filetypes = { "markdown", "quarto" },
          root_dir = require("lspconfig.util").root_pattern(".git", ".marksman.toml", "_quarto.yml"),
        },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "html",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
        "bash",
        "html",
        "css",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "vim",
        "yaml",
        "python",
        "julia",
        "r",
      },
      highlight = {
        enabled = true,
        additional_vim_regex_highlighting = false,
      },
    },
  },
  -- below is probably not needed.
  { "nvim-treesitter/nvim-treesitter-textobjects" },
}
