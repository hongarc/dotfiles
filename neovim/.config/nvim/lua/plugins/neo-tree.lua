return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false, -- Set to false to show hidden files
        hide_gitignored = false, -- Optional: Show files ignored by .gitignore
      },
    },
  },
}
