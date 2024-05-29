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

-- if true then
--   return {}
-- end

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
        enabled = true,
        default_method = "molten", -- "molten" or "slime"
        -- ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
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
    ft = { "quarto", "markdown" },
    keys = {
      { "<leader>rA", ":QuartoActivate<cr>", desc = "quarto activate" },
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
      { "<leader>is", ":vsplit term://$SHELL<cr>", desc = "vsplit terminal: shell" },
      { "<leader>iS", ":vsplit term://$SHELL<cr>", desc = "split terminal: shell" },
      { "<leader>iR", ":vsplit term://R<cr>", desc = "vsplit terminal: R" },
      { "<leader>iP", ":vsplit term://python<cr>", desc = "vsplit terminal: python" },
      { "<leader>iI", ":vsplit term://ipython<cr>", desc = "vsplit termianl: ipython" },
      { "<leader>iJ", ":vsplit term://julia<cr>", desc = "vsplit termina: julia" },
    },
    config = function(_, opts)
      local quarto = require("quarto")
      quarto.setup(opts)
      -- local runner = require("quarto.runner")
      -- require("which-key").register({
      --   ["<leader>rc"] = { runner.run_cell, "run cell", silent = true },
      --   ["<leader>ra"] = { runner.run_above, "run cell and above", silent = true },
      --   -- ["<leader>rA"] = { runner.run_all, "run all cells", silent = true },
      --   ["<leader>rl"] = { runner.run_line, "run line", silent = true },
      --   ["<leader>rv"] = { runner.run_range, "run visual range", silent = true, mode = "v" },
      --   ["<leader>RA"] = {
      --     function()
      --       runner.run_all(true)
      --     end,
      --     "run all cells of all languages",
      --     silent = true,
      --   },
      -- })
    end,
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
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "jmbuhr/otter.nvim" },
      { "hrsh7th/cmp-nvim-lsp" },
      -- { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-calc" },
      { "hrsh7th/cmp-emoji" },
      { "saadparwaiz1/cmp_luasnip" },
      { "f3fora/cmp-spell" },
      { "ray-x/cmp-treesitter" },
      { "kdheepak/cmp-latex-symbols" },
      { "jmbuhr/cmp-pandoc-references" },
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
      { "onsails/lspkind-nvim" },
    },

    -- @param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      -- lspkind.init()
      opts.sources = { -- cmp.config.sources({
        { name = "otter" },
        {
          name = "path",
          -- option = {
          --   get_cwd = function()
          --     return vim.fs.dirname(vim.fs.find({ ".git", ".marksman.toml", "_quarto.yml" }, { upward = true })[1])
          --   end,
          --get_cwd = require('cmp-path').

          -- get_cwd = function()
          -- return require("lspconfig.util").root_pattern(".git", ".marksman.toml", "_quarto.yml") or
          -- end,

          -- get_cwd = function(fname)
          --       return vim.fs.dirname(vim.fs.find({ ".git", ".marksman.toml", "_quarto.yml" }, { upward = true })[1]),
          --         or
          --     return util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(
          --       fname
          --     ) or util.path.dirname(fname)
          -- end,
          -- get_cwd = vim.fs.dirname(vim.fs.find({ ".git", ".marksman.toml", "_quarto.yml" }, { upward = true })[1]),
          -- },
        },
        { name = "nvim_lsp" },
        -- { name = "nvim_lsp_signature_help" },
        { name = "calc" },
        { name = "luasnip", keyword_length = 3, max_item_count = 3 },
        { name = "pandoc_references" },
        { name = "buffer", keyword_length = 5, max_item_count = 3 },
        { name = "spell" },
        { name = "treesitter", keyword_length = 5, max_item_count = 3 },
        { name = "latex_symbols" },
        { name = "emoji" },
      } -- )
      -- formatfunc = function(_, item)
      --   local icons = require("lazyvim.config").icons.kinds
      --   if icons[item.kind] then
      --     item.kind = icons[item.kind] .. item.kind
      --   end
      --   return item
      -- end
      opts.formatting = {
        format = lspkind.cmp_format({
          with_text = true,
          menu = {
            otter = "[🦦]",
            nvim_lsp = "[LSP]",
            luasnip = "[snip]",
            buffer = "[buf]",
            path = "[path]",
            spell = "[spell]",
            pandoc_references = "[ref]",
            tags = "[tag]",
            treesitter = "[TS]",
            calc = "[calc]",
            latex_symbols = "[tex]",
            emoji = "[emoji]",
          },
        }),
      }
      -- opts.view = {
      --   entries = "native",
      -- }
    end,
    ---@param opts cmp.ConfigSchema
    config = function(_, opts)
      local luasnip = require("luasnip")
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      require("cmp").setup(opts)
      -- for friendly snippets
      require("luasnip.loaders.from_vscode").lazy_load()
      -- for custom snippets
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snips" } })
      -- link quarto and rmarkdown to markdown snippets
      luasnip.filetype_extend("quarto", { "markdown" })
      luasnip.filetype_extend("rmarkdown", { "markdown" })
    end,
  },

  -- paste an image to markdown from the clipboard
  -- :PasteImg,
  {
    "dfendr/clipboard-image.nvim",
    keys = {
      { "<leader>ip", ":PasteImg<cr>", desc = "image paste" },
    },
    cmd = {
      "PasteImg",
    },
    config = function()
      require("clipboard-image").setup({
        quarto = {
          img_dir = "img",
          affix = "![](%s)",
        },
      })
    end,
  },

  -- preview equations
  {
    "jbyuki/nabla.nvim",
    keys = {
      { "<leader>rn", ':lua require"nabla".toggle_virt()<cr>', desc = "Nabla toggle equations" },
      { "<leader>rN", ':lua require"nabla".popup()<cr>', desc = "Nabla hover equation" },
    },
  },
}
