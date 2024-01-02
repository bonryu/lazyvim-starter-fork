if true then
  return {}
end
return {
  {
    "quarto-dev/quarto-nvim",
    dev = false,
    dependencies = {
      {
        "jmbuhr/otter.nvim",
        dev = false,
        dependencies = {
          { "neovim/nvim-lspconfig" },
        },
        opts = {
          lsp = {
            hover = {
              border = require("misc.style").border,
            },
          },
          buffers = {
            -- if set to true, the filetype of the otterbuffers will be set.
            -- otherwise only the autocommand of lspconfig that attaches
            -- the language server will be executed without setting the filetype
            set_filetype = true,
          },
        },
      },
    },
    opts = {
      lspFeatures = {
        languages = { "r", "python", "julia", "bash", "lua", "html", "dot" },
      },
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
        -- r for repl
        ["<leader>rm"] = { mark_terminal, "mark terminal" },
        ["<leader>rs"] = { set_terminal, "set terminal" },
        ["<leader>rt"] = { toggle_slime_tmux_nvim, "toggle tmux/nvim terminal" },
      })
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
}
