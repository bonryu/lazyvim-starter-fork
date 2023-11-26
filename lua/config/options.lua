-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- % is escape character, = is separation point ofr alignment,
-- m is modifiable flag for the buffer,
-- f is path of the file opened in the buffer.
vim.opt.winbar = "%=%m %f"
local options = {
  -- guicursor = "",

  ignorecase = true, -- ignore case in search patterns
  smartcase = true, -- smart case
  -- smartindent = true,
  autoindent = true,
  breakindent = true,
  breakindentopt = { "shift:2" },
  wrap = true,
  linebreak = true,
  swapfile = false,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
 
local function isempty(s)
  return s == nil or s == ""
end

-- custom python provider
local conda_prefix = os.getenv("CONDA_PREFIX")
if not isempty(conda_prefix) then
  vim.g.python_host_prog = conda_prefix .. "/bin/python"
  vim.g.python3_host_prog = conda_prefix .. "/bin/python"
  vim.env.VIRTUAL_ENV = conda_prefix
  vim.env.VENV_DIR = conda_prefix
else
  vim.g.python_host_prog = "python"
  vim.g.python3_host_prog = "python3"
end
