export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
ZSH_CONFIG="$XDG_CONFIG_HOME/zsh"

# ---- Helpers used by config modules ----
run_if_exists() {
  command -v "$1" >/dev/null 2>&1 && "$@"
}

# Eval init script if command exists (avoids premature command substitution)
eval_init() {
  local cmd="$1"; shift
  command -v "$cmd" >/dev/null 2>&1 && eval "$("$cmd" "$@")"
}

# ---- Load config modules (order matters) ----
# completion must run before plugins (plugins call `compdef`, defined by compinit)
# starship/fastfetch in tools must run AFTER keys/plugins to be the last precmd hook
for f in options path completion plugins keys tools aliases; do
  [[ -r "$ZSH_CONFIG/$f.zsh" ]] && source "$ZSH_CONFIG/$f.zsh"
done

# Kiro shell integration (only when Kiro launched this shell)
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"
