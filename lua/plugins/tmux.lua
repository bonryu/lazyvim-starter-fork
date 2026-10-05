return {
  --register the plugin
  {
    "aserowy/tmux.nvim",
    -- Needs Neovim >= 0.12.5. Before that, an OSC 52 copy from a :terminal
    -- program (e.g. Claude Code's copy-on-select) reached tmux.nvim's command
    -- clipboard provider with newlines turned into NUL bytes: middle-click
    -- pasted one line of ^@, and register sync hit E976. Fixed upstream in
    -- neovim/neovim#41097 (backport #41171).
    opts = {
      navigation = {
        -- cycles to opposite pane while navigating into the border
        cycle_navigation = true,

        -- enables default keybindings (C-hjkl) for normal mode
        enable_default_keybindings = true,

        -- prevents unzoom tmux when navigating beyond vim border
        persist_zoom = false,
      },
      resize = {
        -- enables default keybindings (A-hjkl) for normal mode
        enable_default_keybindings = true,

        -- sets resize steps for x axis
        resize_step_x = 1,

        -- sets resize steps for y axis
        resize_step_y = 1,
      },
    },
  },
}
