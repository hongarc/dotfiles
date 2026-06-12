# ===== MISE (version manager) — must come before tools it manages =====
[ -x ~/.local/bin/mise ] && eval "$(~/.local/bin/mise activate zsh)"

# ===== BAT =====
export BAT_THEME="Catppuccin Frappe"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# ===== FZF =====
export FZF_COMPLETION_TRIGGER='//'

export FZF_DEFAULT_OPTS="
  --border rounded
  --info inline-right
  --prompt '❯ '
  --pointer '▶'
  --marker '✓'
  --color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284
  --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf
  --color=marker:#babbf1,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284
  --color=selected-bg:#51576d"

# Ctrl-R — history with preview + copy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}'
  --preview-window down:3:wrap:hidden
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --header 'Ctrl-/ preview · Ctrl-Y copy'"

# Ctrl-T — file picker with bat preview
export FZF_CTRL_T_OPTS="
  --preview '(bat --style=numbers --color=always --line-range :300 {} 2>/dev/null || cat {}) 2>/dev/null'
  --preview-window right:60%:wrap"

# Alt-C — directory picker with tree preview
export FZF_ALT_C_OPTS="
  --preview 'eza --tree --color=always --level=2 {} 2>/dev/null || ls -la {}'
  --preview-window right:50%"

# Use fd if installed (faster, respects .gitignore)
if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi

command -v fzf >/dev/null 2>&1 && source <(fzf --zsh)

# ===== ZOXIDE (smart cd) =====
eval_init zoxide init zsh

# zz — interactive directory picker using zoxide's built-in fzf UI
# Usage: zz [query]   (ESC / cancel is a no-op)
# Note: `zi` is zoxide's native equivalent; `zz` is kept as a familiar alias.
zz() {
  local dir
  dir=$(zoxide query -i -- "$@") && [[ -n "$dir" ]] && cd "$dir"
}

# ===== THEFUCK (lazy-loaded; first `f` call pays ~200ms Python startup) =====
f() {
  unfunction f
  eval_init thefuck --alias f
  f "$@"
}

# ===== BUN COMPLETIONS =====
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# ===== STARSHIP PROMPT (must be LAST — its precmd hook should run after everything) =====
eval_init starship init zsh

# ===== FASTFETCH (Ghostty welcome banner) =====
if [ "$TERM_PROGRAM" = "ghostty" ] && [ -z "$NVIM" ]; then
  run_if_exists fastfetch --config hypr
fi
