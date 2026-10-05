-- Ctrl+hjkl in snacks terminals (incl. the claudecode.nvim window) navigates via
-- tmux.nvim, like every other mode (config/keymaps.lua) and tmux itself.
-- LazyVim's defaults (lazyvim/plugins/util.lua) use `wincmd`, which stops at the
-- edge of Neovim instead of crossing into the neighbouring tmux pane. As there,
-- floating terminals pass the key through, since a float has no neighbours.
local function tmux_nav(key, direction)
  ---@param self snacks.terminal
  return function(self)
    if self:is_floating() then
      return "<c-" .. key .. ">"
    end
    vim.schedule(function()
      require("tmux")["move_" .. direction]()
    end)
  end
end

-- Esc Esc, inverted from snacks' default: a *slow* double tap leaves terminal
-- mode, a fast one reaches the program. In the Claude window that means:
--   second Esc < 200 ms after the first  -> both go to Claude (clears input)
--   second Esc 200 ms - 1 s after        -> normal mode
--   anything slower                      -> independent Escs, both to Claude
-- A single Esc always reaches the program at once (cancelling a response).
local ESC_FAST_MS, ESC_SLOW_MS = 200, 1000

---@param self snacks.terminal
local function esc_slow_to_normal(self)
  local now = (vim.uv or vim.loop).now()
  local gap = now - (self.esc_last or -math.huge)
  if gap >= ESC_FAST_MS and gap <= ESC_SLOW_MS then
    self.esc_last = nil
    vim.cmd("stopinsert")
    return ""
  end
  self.esc_last = now
  return "<esc>"
end

return {
  {
    "snacks.nvim",
    opts = {
      terminal = {
        win = {
          keys = {
            term_normal = { "<esc>", esc_slow_to_normal, desc = "Slow double Esc to normal mode", expr = true, mode = "t" },
            nav_h = { "<C-h>", tmux_nav("h", "left"), desc = "Go to Left Window", expr = true, mode = "t" },
            nav_j = { "<C-j>", tmux_nav("j", "bottom"), desc = "Go to Lower Window", expr = true, mode = "t" },
            nav_k = { "<C-k>", tmux_nav("k", "top"), desc = "Go to Upper Window", expr = true, mode = "t" },
            nav_l = { "<C-l>", tmux_nav("l", "right"), desc = "Go to Right Window", expr = true, mode = "t" },
          },
        },
      },
    },
  },
}
