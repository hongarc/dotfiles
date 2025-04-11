return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false, -- Set to false to show hidden files
        hide_gitignored = false, -- Optional: Show files ignored by .gitignore
      },
    },
    window = {
      mappings = {
        ["l"] = "show_file_details",
        ["i"] = "open",
        -- ["n"] = "move_cursor_down",
        ["e"] = false,
        -- ["k"] = "move_cursor_up",
      }
    }
  },
}
