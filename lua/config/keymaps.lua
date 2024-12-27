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

-- better indenting
vim.keymap.set("v", "<", "<Nop>")
vim.keymap.set("v", ">", "<Nop>")
map("v", "<", "<gv" .. br.nshift .. "h")
map("v", ">", ">gv" .. br.nshift .. "l")
vim.keymap.set("n", "<<", "<Nop>")
vim.keymap.set("n", ">>", "<Nop>")
map("n", "<<", "<<" .. br.nshift .. "h", { remap = false })
map("n", ">>", ">>" .. br.nshift .. "l", { remap = false })

-- remove keymaps set by Folke found in ~/.local/share/nvimLazy/lazy/LazyVim/lua/lazyvim/config/keymaps.lua
vim.keymap.set({ "n", "v", "i" }, "<A-h>", "<Nop>")
vim.keymap.set({ "n", "v", "i" }, "<A-j>", "<Nop>")
vim.keymap.set({ "n", "v", "i" }, "<A-k>", "<Nop>")
vim.keymap.set({ "n", "v", "i" }, "<A-l>", "<Nop>")
vim.keymap.set("n", "<C-Left>", "<Nop>")
vim.keymap.set("n", "<C-Down>", "<Nop>")
vim.keymap.set("n", "<C-Up>", "<Nop>")
vim.keymap.set("n", "<C-Right>", "<Nop>")

-- Move Lines
map("n", "<C-S-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<C-S-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<C-S-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<C-S-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<C-S-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<C-S-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Move to window using the <Ctrl> hjkl keys
map(
  { "n", "v", "i" },
  "<C-h>",
  [[<cmd>lua require("tmux").move_left()<cr>]],
  { desc = "Go to left window", remap = true }
)
map(
  { "n", "v", "i" },
  "<C-j>",
  [[<cmd>lua require("tmux").move_bottom()<cr>]],
  { desc = "Go to lower window", remap = true }
)
map(
  { "n", "v", "i" },
  "<C-k>",
  [[<cmd>lua require("tmux").move_top()<cr>]],
  { desc = "Go to upper window", remap = true }
)
map(
  { "n", "v", "i" },
  "<C-l>",
  [[<cmd>lua require("tmux").move_right()<cr>]],
  { desc = "Go to right window", remap = true }
)

-- Resize window using <Alt-Shift> hjkl keys
-- map("n", "<A-K>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
-- map("n", "<A-L>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" }) -- Resize window using <ctrl> arrow keys
-- map("n", "<A-J>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
-- map("n", "<A-H>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })

map("n", "<C-Up>", [[<cmd>lua require("tmux").resize_top()<cr>]], { desc = "Increase window height" })
map("n", "<C-Right>", [[<cmd>lua require("tmux").resize_right()<cr>]], { desc = "Increase window width" })
map("n", "<C-Down>", [[<cmd>lua require("tmux").resize_bottom()<cr>]], { desc = "Decrease window height" })
map("n", "<C-Left>", [[<cmd>lua require("tmux").resize_left()<cr>]], { desc = "Decrease window width" })
map("n", "<A-k>", [[<cmd>lua require("tmux").resize_top()<cr>]], { desc = "Increase window height" })
map("n", "<A-l>", [[<cmd>lua require("tmux").resize_right()<cr>]], { desc = "Increase window width" })
map("n", "<A-j>", [[<cmd>lua require("tmux").resize_bottom()<cr>]], { desc = "Decrease window height" })
map("n", "<A-h>", [[<cmd>lua require("tmux").resize_left()<cr>]], { desc = "Decrease window width" })

-- remap <leader>[y|Y] to copy to system clipboard
map({ "n", "v" }, "<leader>y", [["+y]], { desc = '"+y Copy to system clipboard' })
map({ "n", "v" }, "<leader>p", [["+p]], { desc = '"+p Paste from system clipboard' })
map({ "n", "v" }, "<leader>Y", [["+Y]], { desc = '"+Y Copy to system clipboard' })
map({ "n", "v" }, "<leader>P", [["+P]], { desc = '"+P Paste from system clipboard' })

-- greatest remap ever
-- delete into the null/void register, then paste before. Use like this:
-- 1. yiw foo
-- 2. viw bar
-- 3. p to replace bar with foo.
-- 4. optionally "p" to keep pasting foo after the newly pasted "foo"
-- vim.keymap.set({ "x" }, "p", [["_dP]])
map("x", "p", [["_dP]], { desc = '[["_dP]] delete into _ register and paste before' })

-- open the last telescope picker that happened to be open previously
map(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "Resume Telescope" }
)
-- vim.keymap.set(
--   "n",
--   "<leader>sx",
--   require("telescope.builtin").resume,
--   { noremap = true, silent = true, desc = "Resume Telescope" }
-- )

-- buffers
if Util.has("bufferline.nvim") then
  map("n", "<C-S-PageDown>", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer right" })
  map("n", "<C-S-PageUp>", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer left" })
end

map("n", "[<tab>", "gT", { desc = "Go to previous tab page" })
map("n", "]<tab>", "gt", { desc = "Go to next tab page" })
