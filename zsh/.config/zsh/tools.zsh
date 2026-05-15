# ===== MISE (version manager) — must come before tools it manages =====
[ -x ~/.local/bin/mise ] && eval "$(~/.local/bin/mise activate zsh)"

# ===== FZF =====
export FZF_COMPLETION_TRIGGER='//'

# Global look & feel — Catppuccin Frappé
export FZF_DEFAULT_OPTS="
  --height 60%
  --layout reverse
  --border rounded
  --margin 1
  --padding 1
  --info inline-right
  --prompt '❯ '
  --pointer '▶'
  --marker '✓'
  --color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284
  --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf
  --color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284
  --color=border:#737994"

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
