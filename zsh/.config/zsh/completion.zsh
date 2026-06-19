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

# ===== DOCKER COMPLETION (guarded — only load when binary exists) =====
# These run after compinit so `compdef` is available.

# docker + docker compose: covers both `docker <TAB>` and `docker compose <TAB>`
# Explicit source <(...) ensures `docker compose <TAB>` subcommands work reliably,
# complementing the omz docker plugin (the plugin's fpath _docker runs after
# compinit and may not cover compose sub-commands on all systems).
# Guard on the `completion` subcommand actually existing — old docker (e.g. the
# 1.x/19.x on some distros) has the binary but no `docker completion`, which would
# otherwise print "'completion' is not a docker command." on every shell start.
if command -v docker >/dev/null 2>&1; then
  _docker_comp="$(docker completion zsh 2>/dev/null)" \
    && [[ -n "$_docker_comp" ]] && source <(printf '%s' "$_docker_comp")
  unset _docker_comp
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
