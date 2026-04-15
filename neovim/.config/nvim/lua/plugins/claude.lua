return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    -- Server Configuration
    port_range = { min = 10000, max = 65535 },
    auto_start = true,
    log_level = "info",
    terminal_cmd = nil,

    -- Send/Focus Behavior
    focus_after_send = false,

    -- Selection Tracking
    track_selection = true,
    visual_demotion_delay_ms = 50,

    -- Terminal Configuration (float window)
    terminal = {
      split_side = "right",
      split_width_percentage = 0.30,
      provider = "auto",
      auto_close = true,
      ---@module "snacks"
      ---@type snacks.win.Config|{}
      snacks_win_opts = {
        position = "float",
        width = 0.85,
        height = 0.85,
        border = "rounded",
        backdrop = 80,
        keys = {
          claude_hide = {
            "<C-,>",
            function(self)
              self:hide()
            end,
            mode = { "t", "n" },
            desc = "Hide Claude",
          },
        },
      },
      provider_opts = {
        external_terminal_cmd = nil,
      },
    },

    -- Diff Integration
    diff_opts = {
      layout = "horizontal",
      open_in_new_tab = false,
      keep_terminal_focus = false,
      hide_terminal_in_new_tab = false,
    },
  },
  keys = {
    { "<C-,>", "<cmd>ClaudeCodeFocus<cr>", mode = { "n", "x" }, desc = "Claude Code" },
  },
}
