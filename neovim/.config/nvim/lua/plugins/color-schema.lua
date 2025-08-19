return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato",
      transparent_background = true,
      show_end_of_buffer = true,
      styles = {
        comments = { "italic" }, -- Friendly, subtle
        conditionals = { "italic" }, -- Stand out logic flow
        loops = { "italic" }, -- Like conditionals for consistency
        functions = { "italic", "bold" }, -- Emphasize function names
        keywords = { "bold" }, -- Core language constructs
        strings = {}, -- Leave clean, easy to read
        variables = {}, -- Neutral, to avoid visual clutter
        numbers = { "italic" }, -- Subtle styling
        booleans = { "bold", "underline" }, -- Emphasize true/false clearly
        properties = { "italic" }, -- Helps distinguish object properties
        types = { "bold" }, -- Strong presence for types (TypeScript, etc.)
        operators = {}, -- Leave neutral
        -- miscs = {}, -- Can be set if you want to tweak `@constant`, `@field`, etc.
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-frappe",
    },
  },
}
