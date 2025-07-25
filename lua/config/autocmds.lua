-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("text_comments"),
  pattern = { "text" },
  callback = function()
    vim.cmd("set comments-=fb:-")
    vim.cmd("set comments+=b:-")
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup("python_filetype"),
  desc = "Auto select virtualenv Nvim open",
  pattern = "python",
  callback = function()
    local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
    if venv ~= "" then
      require("venv-selector").retrieve_from_cache()
    end
  end,
  once = true,
})

-- vim.api.nvim_create_autocmd("FileType", {
--   group = augroup("python_filetype"),
--   pattern = { "*.py" },
--   callback = function()
--     vim.keymap.set('n', "[l",  )
--
--   end,
-- })

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("python_filetype"),
  desc = "default b:dispatch variable for python files",
  pattern = "python",
  callback = function()
    vim.cmd([[
      compiler pyunit
      setlocal makeprg=python3\ %
    ]])
  end,
})
