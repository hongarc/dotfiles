# ===== dotdoctor — audit the CLI tools this dotfiles setup expects =====
# Reports which tools are installed vs missing, and suggests an install command
# for the current OS (brew on macOS, source/installer hints on Linux/EC2).
#
#   dotdoctor        # full report (installed + missing)
#   dotdoctor -q     # only show what's missing
#
# Record format:  name:category:brew-formula:linux-install-hint
# (the linux hint may contain ':' — only the first three fields are split.)
dotdoctor() {
  emulate -L zsh
  local quiet=0
  [[ "$1" == "-q" || "$1" == "--missing" ]] && quiet=1

  local os mgr; os=$(uname -s)
  [[ "$os" == "Darwin" ]] && mgr="brew" || mgr="linux"

  local -a tools=(
    # --- core: prompt, navigation, fuzzy, listing (zsh config uses these directly) ---
    "starship:core:starship:curl -sS https://starship.rs/install.sh | sh -s -- -b ~/.local/bin -y"
    "zoxide:core:zoxide:curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh"
    "fzf:core:fzf:git clone --depth 1 https://github.com/junegunn/fzf ~/.fzf && ~/.fzf/install --all"
    "fd:core:fd:cargo install fd-find   (or: sudo yum install -y fd-find)"
    "bat:core:bat:cargo install --locked bat   (pkg may be named batcat)"
    "eza:core:eza:cargo install eza"
    "mise:core:mise:curl https://mise.run | sh"
    # --- base: bootstrap + editors + multiplexer ---
    "git:base:git:sudo yum install -y git"
    "stow:base:stow:sudo yum install -y stow   (or: pip install --user stow)"
    "tmux:base:tmux:build >=3.3 from source — see tmux/README.md"
    "nvim:base:neovim:sudo yum install -y neovim   (or use the AppImage)"
    # --- extra: nice-to-have TUIs + helpers ---
    "gh:extra:gh:https://github.com/cli/cli#installation"
    "lazygit:extra:lazygit:https://github.com/jesseduffield/lazygit#installation"
    "lazydocker:extra:lazydocker:https://github.com/jesseduffield/lazydocker#installation"
    "yazi:extra:yazi:cargo install --locked yazi-fm yazi-cli"
    "btop:extra:btop:sudo yum install -y btop"
    "thefuck:extra:thefuck:pip install --user thefuck"
    "bun:extra:bun:curl -fsSL https://bun.sh/install | bash"
    "fastfetch:extra:fastfetch:sudo yum install -y fastfetch   (may need EPEL/COPR)"
  )

  local -A label=(core "Core (shell UX)" base "Base (bootstrap)" extra "Extra (optional)")
  local missing=0 total=0
  print -P "%B🩺 dotdoctor%b — $os, installer: %F{cyan}$mgr%f\n"

  local group rec name rest cat brewf hint cmd
  for group in core base extra; do
    print -P "%B${label[$group]}%b"
    for rec in $tools; do
      name=${rec%%:*}; rest=${rec#*:}
      cat=${rest%%:*}; rest=${rest#*:}
      [[ "$cat" == "$group" ]] || continue
      brewf=${rest%%:*}; hint=${rest#*:}
      (( total++ ))
      if command -v "$name" >/dev/null 2>&1; then
        (( quiet )) || print -P "  %F{green}✓%f $name"
      else
        (( missing++ ))
        [[ "$mgr" == "brew" ]] && cmd="brew install $brewf" || cmd="$hint"
        print -P "  %F{red}✗%f %B$name%b\n      %F{yellow}$cmd%f"
      fi
    done
  done

  print
  if (( missing )); then
    print -P "%F{red}✗ $missing of $total missing.%f Run the suggested command(s) above."
  else
    print -P "%F{green}✓ All $total tools installed.%f"
  fi
}
