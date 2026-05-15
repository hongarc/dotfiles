# ===== KEY BINDINGS =====
# History substring search (zsh-users/zsh-history-substring-search plugin)
bindkey '^[[A' history-substring-search-up      # Up arrow
bindkey '^[[B' history-substring-search-down    # Down arrow

# Colemak vi-mode: e/n for up/down
bindkey -M vicmd 'e' history-substring-search-up
bindkey -M vicmd 'n' history-substring-search-down

# Alt+E / Alt+N — Colemak-mapped up/down through history
bindkey '^[e' up-line-or-search
bindkey '^[n' down-line-or-search

# Alt+I — accept autosuggestion (Colemak position for "right")
bindkey '^[i' autosuggest-accept

# ===== HISTORY-SUBSTRING-SEARCH OPTIONS =====
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=''
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=''
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_TIMEOUT=0
HISTORY_SUBSTRING_SEARCH_PREFIXED='^'
