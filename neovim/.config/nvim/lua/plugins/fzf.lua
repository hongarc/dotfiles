return {
  "ibhagwan/fzf-lua",
  opts = function(_, opts)
    opts.fzf_opts = {
      ["--ignore-case"] = "",
    }
    return opts
  end,
}
