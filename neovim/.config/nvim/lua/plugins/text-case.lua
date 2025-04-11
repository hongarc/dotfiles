return {
  "johmsalas/text-case.nvim",
  config = function()
    require("textcase").setup({
      prefix = "<leader>t",
    })
  end,
}
