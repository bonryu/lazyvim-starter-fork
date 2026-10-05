-- Always show the picker for LSP goto-definition/-type-definition/-implementation,
-- even when there's only one result, so the split/vsplit/tab keys
-- (<C-v>/<C-s>/<C-t>) are always available.
--
-- By default (lazyvim/plugins/extras/editor/snacks_picker.lua's upstream
-- config, in snacks.picker.config.sources), these sources set
-- `auto_confirm = true`, which jumps straight to the result and skips the
-- picker UI whenever there is exactly one match -- the common case for `gd`.
return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          lsp_definitions = { auto_confirm = false },
          lsp_type_definitions = { auto_confirm = false },
          lsp_implementations = { auto_confirm = false },
        },
        win = {
          -- Default "jump to an existing window" is bound to <S-CR>, which
          -- relies on the terminal/tmux distinguishing Shift+Enter from
          -- plain Enter (the Kitty keyboard protocol / xterm
          -- modifyOtherKeys). tmux does not reliably forward this
          -- distinction for Enter specifically, so rebind it to <c-o>
          -- instead -- a single control byte, unambiguous in every
          -- terminal, no protocol negotiation required, and free in both
          -- modes (unlike <c-w>, which is "delete word" in insert mode and
          -- a prefix of <c-w>H/J/K/L in the list). Press `?` in the picker
          -- to see the full keymap list.
          input = {
            keys = {
              ["<S-CR>"] = false,
              ["<c-o>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
            },
          },
          list = {
            keys = {
              ["<S-CR>"] = false,
              ["<c-o>"] = { { "pick_win", "jump" } },
            },
          },
        },
      },
    },
  },
}
