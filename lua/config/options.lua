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
  smartindent = true,
  breakindent = true,
  breakindentopt = { "shift:2" },
  wrap = true,
  linebreak = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
