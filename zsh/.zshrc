# ---- Helper: Run if command exists ----
run_if_exists() {
  if command -v "$1" >/dev/null 2>&1; then
    shift
    "$@"
  fi
}

# ===== HISTORY CONFIGURATION =====
# History file location
HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

# History options
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits
setopt SHARE_HISTORY             # Share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry
setopt HIST_VERIFY               # Don't execute immediately upon history expansion
# ===== END HISTORY =====

# ===== COMPLETION SYSTEM =====
# Initialize completion system with caching
autoload -Uz compinit

# Only run compinit once per day for performance
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
  compdump
else
  compinit -C
fi

# GitHub CLI completions (gh provides its own completions)
run_if_exists gh eval "$(gh completion -s zsh)"
# ===== END COMPLETION =====

# ===== ANTIDOTE PLUGIN MANAGER =====
# Clone antidote if it doesn't exist
if [[ ! -d ${ZDOTDIR:-~}/.antidote ]]; then
  git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
fi

# Source antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

# Initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load
# ===== END ANTIDOTE =====

# ===== PATH CONFIGURATION =====
# Base PATH
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# LM Studio CLI
export PATH="$PATH:$HOME/.cache/lm-studio/bin"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Mise version manager
[ -x ~/.local/bin/mise ] && eval "$(~/.local/bin/mise activate zsh)"
# ===== END PATH =====

# ===== KEY BINDINGS for history substring search =====
# History substring search key bindings (after plugins are loaded)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=''
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=''
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_TIMEOUT=0
HISTORY_SUBSTRING_SEARCH_PREFIXED='^'

# ===== TOOL INITIALIZATION =====
# Starship prompt
run_if_exists starship eval "$(starship init zsh)"

# The Fuck
run_if_exists thefuck eval "$(thefuck --alias f)"

# FZF
export FZF_COMPLETION_TRIGGER='//'
run_if_exists fzf source <(fzf --zsh)

# Fastfetch for Ghostty
if [ "$TERM_PROGRAM" = "ghostty" ] && [ -z "$NVIM" ]; then
  run_if_exists fastfetch fastfetch --config hypr
fi

# Bun shell
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
# ===== END TOOL INITIALIZATION =====

# ===== ALIASES & FUNCTIONS =====
# Directory navigation options
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# Global aliases for directory navigation
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

# Directory stack navigation
alias -- -='cd -'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

# Directory management
alias md='mkdir -p'
alias rd=rmdir

# Directory stack function
function d () {
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -n 10
  fi
}
compdef _dirs d

# List directory contents
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

# Quick project navigation
alias dotfiles='cd ~/project/dotfiles'
alias projects='cd ~/project'
# ===== END ALIASES & FUNCTIONS =====
