-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- This file is automatically loaded by lazyvim.config.init
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

vim.keymap.set({ "n", "v", "i" }, "<A-j>", "<Nop>")
-- vim.keymap.del({ "n", "i", "v" }, "<A-j>")
vim.keymap.set({ "n", "v", "i" }, "<A-k>", "<Nop>")
-- vim.keymap.del({ "n", "i", "v" }, "<A-k>")
vim.keymap.set("n", "<C-h>", "<Nop>")
vim.keymap.set("n", "<C-j>", "<Nop>")
vim.keymap.set("n", "<C-k>", "<Nop>")
vim.keymap.set("n", "<C-l>", "<Nop>")
-- Move Lines
map("n", "<C-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<C-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<C-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<C-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<C-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<C-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Move to window using the <alt> hjkl keys
map("n", "<A-h>", [[<cmd>lua require("tmux").move_left()<cr>]], { desc = "Go to left window", remap = true })
map(
  { "n", "v", "i" },
  "<A-j>",
  [[<cmd>lua require("tmux").move_bottom()<cr>]],
  { desc = "Go to lower window", remap = true }
)
map(
  { "n", "v", "i" },
  "<A-k>",
  [[<cmd>lua require("tmux").move_top()<cr>]],
  { desc = "Go to upper window", remap = true }
)
map("n", "<A-l>", [[<cmd>lua require("tmux").move_right()<cr>]], { desc = "Go to right window", remap = true })

-- Resize window using <Alt-Shift> hjkl keys
-- map("n", "<A-K>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
-- map("n", "<A-L>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" }) -- Resize window using <ctrl> arrow keys
-- map("n", "<A-J>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
-- map("n", "<A-H>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })

map("n", "<A-K>", [[<cmd>lua require("tmux").resize_top()<cr>]], { desc = "Increase window height" })
map("n", "<A-L>", [[<cmd>lua require("tmux").resize_right()<cr>]], { desc = "Increase window width" }) -- Resize window using <ctrl> arrow keys
map("n", "<A-J>", [[<cmd>lua require("tmux").resize_bottom()<cr>]], { desc = "Decrease window height" })
map("n", "<A-H>", [[<cmd>lua require("tmux").resize_left()<cr>]], { desc = "Decrease window width" })

-- open the last telescope picker that happened to be open previously
vim.keymap.set(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "Resume Telescope" }
)
