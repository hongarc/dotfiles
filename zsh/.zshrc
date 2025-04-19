# ---- Helper: Run if command exists ----
run_if_exists() {
  if command -v "$1" >/dev/null 2>&1; then
    shift
    "$@"
  fi
}

# ---- System PATH Configuration ----
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# ---- Oh My Zsh Configuration ----
export ZSH="$HOME/.oh-my-zsh"

# ---- Theme Configuration ----
ZSH_THEME="awesomepanda"

# ---- Completion Configuration ----
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"

# ---- Auto-Update Configuration ----
# zstyle ':omz:update' mode disabled
# zstyle ':omz:update' mode auto
# zstyle ':omz:update' mode reminder
# zstyle ':omz:update' frequency 13

# ---- Plugin Configuration ----
plugins=(
  git                # Git plugin for Zsh
  gh                 # GitHub CLI plugin
  git-auto-fetch     # Automatically fetch updates from Git remotes
  zsh-autosuggestions # Auto-suggestions for commands
  zsh-syntax-highlighting # Syntax highlighting for commands
  fzf-tab            # Fuzzy tab completion
  zoxide             # Faster `cd` with auto-jumping
  terraform          # Terraform CLI plugin
)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# ---- User Configuration ----
# export LANG=en_US.UTF-8
# export ARCHFLAGS="-arch $(uname -m)"

# ---- LM Studio CLI Configuration ----
export PATH="$PATH:$HOME/.cache/lm-studio/bin"

# ---- Bun Configuration ----
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ---- Starship Prompt Initialization (Optional) ----
run_if_exists starship eval "$(starship init zsh)"

# ---- The Fuck Configuration ----
run_if_exists thefuck eval "$(thefuck --alias f)"

# ---- FZF Configuration ----
export FZF_COMPLETION_TRIGGER='//'
run_if_exists fzf source <(fzf --zsh)

# ---- Fastfetch for Ghostty ----
if [ "$TERM_PROGRAM" = "ghostty" ] && [ -z "$NVIM" ]; then
  run_if_exists fastfetch fastfetch --config hypr
fi

# ---- Mise Version Manager ----
[ -x ~/.local/bin/mise ] && eval "$(~/.local/bin/mise activate zsh)"

