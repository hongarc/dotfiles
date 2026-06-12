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

# ===== FZF GIT HELPERS =====
# All functions are guarded on both `git` and `fzf` being present.
# They inherit FZF_DEFAULT_OPTS (Catppuccin colours, border, prompt) automatically.

# fbr — fuzzy branch checkout (local + remote).
# Preview pane shows recent log for the highlighted branch.
# Select with Enter to check out; Escape/Ctrl-C is a no-op.
fbr() {
  command -v fzf >/dev/null 2>&1 || { print "fbr: fzf not found" >&2; return 1; }
  git rev-parse --git-dir >/dev/null 2>&1  || { print "fbr: not a git repo" >&2; return 1; }

  local branch
  branch=$(
    git branch --all --sort=-committerdate \
      --format='%(refname:short)' 2>/dev/null \
      | grep -v 'HEAD' \
      | fzf \
          --height=60% --layout=reverse --border=rounded \
          --prompt='branch ❯ ' \
          --header='Enter=checkout  Ctrl-C=abort' \
          --preview='git log --oneline --color=always --max-count=20 {1} 2>/dev/null' \
          --preview-window=right:55%:wrap
  ) || return 0   # ESC = silent exit

  # Strip remote prefix (e.g. "origin/main" → "main") for local checkout
  git checkout "${branch#origin/}"
}

# fco — fuzzy checkout: branches AND tags in one list.
# Useful when you need to jump to a tagged release without remembering its name.
fco() {
  command -v fzf >/dev/null 2>&1 || { print "fco: fzf not found" >&2; return 1; }
  git rev-parse --git-dir >/dev/null 2>&1  || { print "fco: not a git repo" >&2; return 1; }

  local target
  target=$(
    {
      git branch --all --sort=-committerdate \
        --format='%(refname:short)' 2>/dev/null | grep -v 'HEAD'
      git tag --sort=-version:refname 2>/dev/null | sed 's/^/tag: /'
    } \
      | fzf \
          --height=60% --layout=reverse --border=rounded \
          --prompt='checkout ❯ ' \
          --header='Enter=checkout  Ctrl-C=abort' \
          --preview='
            ref={1}
            [[ $ref == tag:* ]] && ref=${ref#tag: }
            git log --oneline --color=always --max-count=20 "$ref" 2>/dev/null
          ' \
          --preview-window=right:55%:wrap
  ) || return 0

  # Strip "tag: " prefix if selected from tag list
  local ref="${target#tag: }"
  git checkout "${ref#origin/}"
}

# fgl — fuzzy git log browser.
# Highlights the selected commit in the preview pane with a full diff.
# Press Enter to copy the commit hash to the clipboard (pbcopy); Ctrl-C to abort.
# On Linux: change `pbcopy` to `xclip -selection clipboard` or `wl-copy`.
fgl() {
  command -v fzf >/dev/null 2>&1 || { print "fgl: fzf not found" >&2; return 1; }
  git rev-parse --git-dir >/dev/null 2>&1  || { print "fgl: not a git repo" >&2; return 1; }

  local commit
  commit=$(
    git log --oneline --color=always --decorate "$@" \
      | fzf \
          --ansi \
          --height=80% --layout=reverse --border=rounded \
          --prompt='log ❯ ' \
          --header='Enter=copy-hash  Ctrl-C=abort' \
          --preview='git show --stat --color=always {1} 2>/dev/null | head -80' \
          --preview-window=right:55%:wrap \
          --bind 'ctrl-d:preview-page-down,ctrl-u:preview-page-up'
  ) || return 0

  local hash
  hash=$(awk '{print $1}' <<< "$commit")
  printf '%s' "$hash" | pbcopy 2>/dev/null && print "Copied: $hash"
}

# ===== STARSHIP PROMPT (must be LAST — its precmd hook should run after everything) =====
eval_init starship init zsh

# ===== FASTFETCH (Ghostty welcome banner) =====
if [ "$TERM_PROGRAM" = "ghostty" ] && [ -z "$NVIM" ]; then
  run_if_exists fastfetch --config hypr
fi
