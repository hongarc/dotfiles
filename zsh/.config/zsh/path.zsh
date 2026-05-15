# ===== EDITOR =====
export EDITOR='nvim'
export VISUAL='nvim'
export GIT_EDITOR='nvim'

# ===== ENV VARS =====
export BUN_INSTALL="$HOME/.bun"
export PNPM_HOME="$HOME/Library/pnpm"

# ===== PATH =====
# Order matters: earlier entries win. `typeset -U` keeps PATH deduped
# automatically across reloads.
typeset -U path PATH

path=(
  $HOME/bin
  $HOME/.local/bin
  $BUN_INSTALL/bin
  $PNPM_HOME
  $HOME/.cache/lm-studio/bin
  /usr/local/bin
  $path
)

# Apple Silicon Homebrew git (prefer over /usr/bin/git when present)
[[ -d /opt/homebrew/opt/git/bin ]] && path=(/opt/homebrew/opt/git/bin $path)
