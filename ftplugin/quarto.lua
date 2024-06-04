vim.b.slime_cell_delimiter = "```"

-- wrap text, but by word no character
-- indent the wrappped line
-- vim.wo.wrap = true
-- vim.wo.linebreak = true
-- vim.wo.breakindent = true
-- vim.wo.showbreak = "|"
--
--
local options = {
  -- guicursor = "",

  shiftwidth = 2,
  tabstop = 2,
  smartindent = true,
  autoindent = true,
  breakindent = true,
  breakindentopt = { "shift:" .. 2 },
  wrap = true,
  linebreak = true,
  autochdir = false,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
-- don't run vim ftplugin on top
vim.api.nvim_buf_set_var(0, "did_ftplugin", true)

require("quarto").activate()
-- require("otter").dev_setup()
