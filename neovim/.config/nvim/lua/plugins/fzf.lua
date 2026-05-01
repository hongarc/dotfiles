return {
  {
    "ibhagwan/fzf-lua",
    opts = function(_, opts)
      -- Files picker: case-insensitive fzf filtering
      opts.files = opts.files or {}
      opts.files.fzf_opts = opts.files.fzf_opts or {}
      opts.files.fzf_opts["-i"] = ""

      -- Grep (ripgrep): case-sensitive
      opts.grep = opts.grep or {}
      opts.grep.rg_opts = "--column --line-number --no-heading --color=always --case-sensitive --max-columns=4096 -e"

      return opts
    end,
  },
}
