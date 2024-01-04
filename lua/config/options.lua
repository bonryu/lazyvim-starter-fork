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
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- custom python provider
local virtual_env = "~/.pyenv/versions/nvim31013"
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
