# ===== COMPLETION SYSTEM =====
# Add cached gh completion before compinit picks it up.
# Regenerate with: gh completion -s zsh > ~/.config/zsh/completions/_gh
fpath=(${ZDOTDIR:-$HOME}/.config/zsh/completions $fpath)

autoload -Uz compinit
# Fast compinit: full security check only if dump is older than 24h, else trust cache.
# `-u` suppresses macOS "insecure directories" warnings from Homebrew dirs.
_zcompf=${ZDOTDIR:-$HOME}/.zcompdump
if [[ $_zcompf(#qNmh+24) ]]; then
  compinit -u
else
  compinit -C -u
fi
unset _zcompf

# ===== COMPLETION STYLING =====
zstyle ':completion:*' menu no                                # let fzf-tab take over
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'     # case-insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:git-checkout:*' sort false              # keep git branch order
zstyle ':completion:*' special-dirs true                      # complete . and ..

# ===== FZF-TAB =====
zstyle ':fzf-tab:*' fzf-flags --height=60% --layout=reverse --border=rounded
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:complete:cd:*' fzf-preview \
  'eza --tree --color=always --level=2 $realpath 2>/dev/null || ls -la $realpath'
zstyle ':fzf-tab:complete:*:*' fzf-preview \
  'bat --color=always --style=numbers --line-range=:300 $realpath 2>/dev/null || cat $realpath 2>/dev/null'
