-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Custom global 'br' is defined in config/globals.lua
br.nshift = 2
local options = {
  -- guicursor = "",

  ignorecase = true, -- ignore case in search patterns
  smartcase = true, -- smart case
  -- smartindent = true,
  autoindent = true,
  breakindent = true,
  breakindentopt = { "shift:" .. br.nshift },
  wrap = true,
  linebreak = true,
  swapfile = false,
  autochdir = false,
  -- % is escape character, = is separation point for alignment,
  -- m is modifiable flag for the buffer,
  -- f is path of the file opened in the buffer.
  winbar = "%=%m %f",
  conceallevel = 0,
  clipboard = "",
  scrolloff = 10,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
vim.opt.diffopt:append("vertical")

-- LSP Server to use for Python.
-- Set to "basedpyright" to use basedpyright instead of pyright.
vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff_lsp"

-- vim.api.nvim_set_hl(0, "@customline", { bg = "#c53b53" })
vim.api.nvim_set_hl(0, "@customline", { bg = "#4fd6be" })
-- custom python provider
local virtual_env = vim.fn.expand("$HOME") .. "/.pyenv/versions/nvim31013"
local python = virtual_env .. "/bin/python3"
vim.g.python3_host_prog = vim.fn.expand(python)
vim.g.python_host_prog = vim.fn.expand(python)

-- local conda_prefix = os.getenv("CONDA_PREFIX")
-- if not br.isempty(conda_prefix) then
--   vim.g.python_host_prog = conda_prefix .. "/bin/python"
--   vim.g.python3_host_prog = conda_prefix .. "/bin/python"
--   vim.env.VIRTUAL_ENV = conda_prefix
--   vim.env.VENV_DIR = conda_prefix
-- else
--   vim.g.python_host_prog = "python"
--   vim.g.python3_host_prog = "python3"
-- end

-- Example for configuring Neovim to load user-installed installed Lua rocks:
-- This is for getting 'https://github.com/3rd/image.nvim' to work
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"
