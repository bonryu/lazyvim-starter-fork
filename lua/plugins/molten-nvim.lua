return {
  {
    "benlubas/molten-nvim",
    -- version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    ft = { "python", "quarto", "markdown", "ipynb" },
    init = function()
      -- these are examples, not defaults. Please see the readme
      -- vim.g.molten_auto_open_output = true
      vim.g.molten_image_provider = "image.nvim"
      -- vim.g.molten_output_win_max_height = 20
      -- vim.g.molten_wrap_output = true
      -- vim.g.molten_virt_text_output = true
      -- vim.g.molten_output_virt_lines = true
      -- vim.g.molten_virt_lines_off_by_1 = true
      -- vim.g.molten_output_win_border = { "", "", "", "" }
      -- vim.g.molten_output_win_border = { "", "-", "", "", "", "_", "", "" }
      -- vim.g.molten_output_win_style = "minimal"
      -- vim.g.molten_output_win_hide_on_leave = true
      -- vim.g.molten_output_win_cover_gutter = false
      -- vim.g.molten_cover_empty_lines = false
      vim.g.molten_auto_open_output = false
      vim.g.molten_output_show_more = true
      vim.g.molten_output_win_border = { "", "━", "", "" }
      vim.g.molten_output_win_max_height = 25
      vim.g.molten_output_virt_lines = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_use_border_highlights = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_wrap_output = true
      vim.g.molten_tick_rate = 175
      vim.g.molten_auto_image_popup = false

      vim.api.nvim_create_autocmd("User", {
        pattern = "MoltenInitPost",
        callback = function()
          -- -- quarto code runner mappings
          -- local r = require("quarto.runner")
          -- vim.keymap.set("n", "<leader>rc", r.run_cell, { desc = "run cell", silent = true })
          -- vim.keymap.set("n", "<leader>ra", r.run_above, { desc = "run cell and above", silent = true })
          -- vim.keymap.set("n", "<leader>rb", r.run_below, { desc = "run cell and below", silent = true })
          -- vim.keymap.set("n", "<leader>rl", r.run_line, { desc = "run line", silent = true })
          -- vim.keymap.set("n", "<leader>rA", r.run_all, { desc = "run all cells", silent = true })
          -- vim.keymap.set("n", "<leader>RA", function()
          --   r.run_all(true)
          -- end, {
          --   desc = "run all cells of all languages",
          --   silent = true,
          -- })

          -- setup some molten specific keybindings
          vim.keymap.set(
            "n",
            "<leader>me",
            ":MoltenEvaluateOperator<CR>",
            { desc = "run operator selection", silent = true }
          )
          vim.keymap.set("n", "<leader>mr", ":MoltenReevaluateCell<CR>", { desc = "re-eval cell", silent = true })
          vim.keymap.set(
            "v",
            "<leader>mv",
            ":<C-u>MoltenEvaluateVisual<CR>gv",
            { desc = "execute visual selection", silent = true }
          )
          vim.keymap.set(
            "n",
            "<leader>mo",
            ":noautocmd MoltenEnterOutput<CR>",
            { desc = "open output window", silent = true }
          )
          vim.keymap.set("n", "<leader>mh", ":MoltenHideOutput<CR>", { desc = "close output window", silent = true })
          vim.keymap.set("n", "<leader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })
          local open = false
          vim.keymap.set("n", "<leader>mt", function()
            open = not open
            vim.fn.MoltenUpdateOption("auto_open_output", open)
          end, { desc = "auto open output", silent = true })

          -- if we're in a python file, change the configuration a little
          if vim.bo.filetype == "python" then
            vim.fn.MoltenUpdateOption("molten_virt_lines_off_by_1", false) -- orig false
            vim.fn.MoltenUpdateOption("molten_virt_text_output", true) -- orig false
          end
        end,
      })

      -- change the configuration when editing a python file
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*.py",
        callback = function(e)
          if string.match(e.file, ".otter.") then
            return
          end
          if require("molten.status").initialized() == "Molten" then
            vim.fn.MoltenUpdateOption("molten_virt_lines_off_by_1", false)
            vim.fn.MoltenUpdateOption("molten_virt_text_output", true) --  orig false
          end
        end,
      })
      -- Undo those config changes when we go back to a markdown or quarto file
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*.qmd", "*.md", "*.ipynb" },
        callback = function()
          if require("molten.status").initialized() == "Molten" then
            vim.fn.MoltenUpdateOption("molten_virt_lines_off_by_1", true)
            vim.fn.MoltenUpdateOption("molten_virt_text_output", true)
          end
        end,
      })

      -- automatically import output chunks from a jupyter notebook
      -- tries to find a kernel that matches the kernel in the jupyter notebook
      -- falls back to a kernel that matches the name of the active venv (if any)
      local imb = function(e) -- init molten buffer
        vim.schedule(function()
          local kernels = vim.fn.MoltenAvailableKernels()
          local try_kernel_name = function()
            local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
            return metadata.kernelspec.name
          end
          local ok, kernel_name = pcall(try_kernel_name)
          if not ok or not vim.tbl_contains(kernels, kernel_name) then
            kernel_name = nil
            local venv = os.getenv("VIRTUAL_ENV")
            if venv ~= nil then
              kernel_name = string.match(venv, "/.+/(.+)")
            end
          end
          if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
            vim.cmd(("MoltenInit %s"):format(kernel_name))
          end
          vim.cmd("MoltenImportOutput")
        end)
      end

      -- automatically import output chunks from a jupyter notebook
      vim.api.nvim_create_autocmd("BufAdd", {
        pattern = { "*.ipynb" },
        callback = imb,
      })

      -- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*.ipynb" },
        callback = function(e)
          if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
            imb(e)
          end
        end,
      })

      -- automatically export output chunks to a jupyter notebook
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.ipynb" },
        callback = function()
          if require("molten.status").initialized() == "Molten" then
            vim.cmd("MoltenExportOutput!")
          end
        end,
      })
    end,

    keys = {
      {
        "<leader>mi",
        function()
          local venv = os.getenv("VIRTUAL_ENV")
          -- local venv = os.getenv("CONDA_PREFIX")
          if venv ~= nil then
            -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
            venv = string.match(venv, "/.+/(.+)")
            vim.cmd(("MoltenInit %s"):format(venv))
          else
            vim.cmd({ "MoltenInit python3" })
          end
        end,
        desc = "Initialize Molten for python3",
      },
      -- -- "At minimum you should setup:"
      -- { "<leader>mo", ":MoltenEvaluateOperator<CR>", silent = true, desc = "run operator selection" },
      -- { "<leader>ms", ":noautocmd MoltenEnterOutput<CR>", silent = true, desc = "show/enter output" },
      -- -- The following are also recommended
      -- { "<leader>mr", "<cmd>MoltenReevaluateCell<CR>", silent = true, desc = "re-evaluate cell" },
      -- {
      --   "<leader>mv",
      --   ":<C-u>MoltenEvaluateVisual<CR>gv",
      --   mode = "v",
      --   silent = true,
      --   desc = "evaluate visual selection",
      -- },
      -- { "<leader>ml", ":MoltenEvaluateLine<CR>", silent = true, desc = "evaluate line" },
      -- { "<leader>mh", ":MoltenHideOutput<CR>", silent = true, desc = "hide output" },
      -- { "<leader>md", ":MoltenDelete<CR>", silent = true, desc = "molten delete cell" },
      -- -- if you work with html outputs:
      -- { "<leader>mx", ":MoltenOpenInBrowser<CR>", silent = true, desc = "open output in browser" },
    },
  },
  -- {
  --   "akinsho/bufferline.nvim",
  --   enabled = false,
  -- },
}
