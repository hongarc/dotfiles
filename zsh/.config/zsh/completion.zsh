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

# ===== DEVOPS COMPLETIONS (guarded — only load when binary exists) =====
# These run after compinit so `compdef` is available.
# Each `source <(...)` pays the startup cost only when the tool is installed.

# kubectl: full tab-completion for commands, flags, resource names
# The ohmyzsh kubectl plugin also calls this, but guarding here is harmless
# (zsh caches compdef calls) and ensures it works without antidote too.
if command -v kubectl >/dev/null 2>&1; then
  # Cache completion to /tmp to avoid 100ms kubectl startup on every shell open.
  _kubectl_comp_cache="${TMPDIR:-/tmp}/zsh_kubectl_completion_$$_$(kubectl version --client --short 2>/dev/null | md5 2>/dev/null || echo 'noversion')"
  if [[ ! -f "$_kubectl_comp_cache" ]]; then
    kubectl completion zsh >| "$_kubectl_comp_cache" 2>/dev/null
  fi
  [[ -f "$_kubectl_comp_cache" ]] && source "$_kubectl_comp_cache"
  unset _kubectl_comp_cache
fi

# helm: sub-command and flag completions
command -v helm >/dev/null 2>&1 && source <(helm completion zsh)

# docker + docker compose: covers both `docker <TAB>` and `docker compose <TAB>`
# Using source <(...) matches the kubectl/helm pattern and bypasses the ohmyzsh
# docker plugin's fpath/cache approach, which runs after compinit.
command -v docker >/dev/null 2>&1 && source <(docker completion zsh)

# terraform: uses bash-style `complete -C`; requires bashcompinit shim
if command -v terraform >/dev/null 2>&1; then
  autoload -Uz bashcompinit && bashcompinit
  complete -o nospace -C "$(command -v terraform)" terraform
fi

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
