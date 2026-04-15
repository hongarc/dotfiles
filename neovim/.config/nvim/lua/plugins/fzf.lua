return {
  {
    "ibhagwan/fzf-lua",
    opts = function(_, opts)
      -- 1. Global fzf behavior (case-insensitivity for filtering)
      opts.fzf_opts = opts.fzf_opts or {}
      opts.fzf_opts["--smart-case"] = ""

      -- 2. Ripgrep behavior (case-insensitivity for the initial search)
      -- This ensures that when you type "word", rg finds "Word" and "WORD"
      opts.grep = opts.grep or {}
      opts.grep.rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e"

      return opts
    end,
  },
}
