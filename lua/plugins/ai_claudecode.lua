return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    opts = {
      -- Claude Code's terminal is Neovim, not tmux. With $TMUX set it wraps its
      -- copy-on-select OSC 52 in tmux's DCS passthrough, which Neovim's terminal
      -- can't parse: "52;c;<base64>" gets printed into the input box until a
      -- resize redraws it. Without TMUX it sends plain OSC 52, which Neovim
      -- hands to the clipboard provider. tmux commands still reach the server
      -- via the default socket.
      -- Unset, not `env = { TMUX = "" }`: an empty TMUX is inherited by any nvim
      -- started inside Claude's terminal, and tmux.nvim treats empty as "in
      -- tmux", runs `tmux -S "" -V`, and crashes in setup.
      terminal_cmd = "env -u TMUX claude",
      terminal = {
        snacks_win_opts = {
          keys = {
            -- LazyVim gives snacks terminals Ctrl+/ (sent as <C-_> by many
            -- terminals) to hide the window. In the Claude window it goes to
            -- Claude instead, where Ctrl+_ is undo.
            hide_slash = false,
            hide_underscore = false,
          },
        },
      },
    },
    -- `cmd` lets lazy.nvim create command stubs that load the plugin on first use,
    -- so `:ClaudeCode` and friends work on a fresh start. Without it, a keys-only
    -- spec defers loading until a <leader>a* mapping is pressed and the commands
    -- would not exist yet.
    cmd = {
      "ClaudeCode",
      "ClaudeCodeFocus",
      "ClaudeCodeSelectModel",
      "ClaudeCodeAdd",
      "ClaudeCodeSend",
      "ClaudeCodeTreeAdd",
      "ClaudeCodeStatus",
      "ClaudeCodeStart",
      "ClaudeCodeStop",
      "ClaudeCodeOpen",
      "ClaudeCodeClose",
      "ClaudeCodeDiffAccept",
      "ClaudeCodeDiffDeny",
      "ClaudeCodeCloseAllDiffs",
    },
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw", "snacks_picker_list" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
}
