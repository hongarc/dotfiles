return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    -- Float Claude in a near-fullscreen popup so it feels like its own app.
    terminal = {
      ---@module "snacks"
      ---@type snacks.win.Config|{}
      snacks_win_opts = {
        position = "float",
        width = 0.95,
        height = 0.95,
        border = "rounded",
        backdrop = 80,
        -- catppuccin's transparent integration sets SnacksNormal bg=NONE, which
        -- makes the Claude terminal buffer render unpainted cells as pure black.
        -- Force this window's Normal to the solid float bg (Frappé mantle), so
        -- title/border (FloatTitle/FloatBorder) match the body instead of going transparent.
        wo = {
          winhighlight = "Normal:NormalFloat,NormalNC:NormalFloat",
        },
        keys = {
          claude_hide = {
            "<C-,>",
            function(self) self:hide() end,
            mode = { "t", "n" },
            desc = "Hide Claude",
          },
        },
      },
    },

    -- Push diffs out of the editing tab so Claude stays foregrounded.
    diff_opts = {
      open_in_new_tab = true,
      keep_terminal_focus = true,
      hide_terminal_in_new_tab = true,
    },
  },
  keys = {
    { "<C-,>", "<cmd>ClaudeCodeFocus<cr>", mode = { "n", "x" }, desc = "Claude Code" },
  },
}
