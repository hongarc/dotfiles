# ===== DIRECTORY NAVIGATION =====
# Global aliases — work anywhere in the command
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

# Directory stack jump
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

# Show top 10 of dir stack with `d`, or pass args through to `dirs`
d() {
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -n 10
  fi
}
compdef _dirs d

# ===== EDITOR =====
alias v='nvim'

# ===== LISTING (eza if available, ls fallback) =====
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons'
  alias l='eza -lah --icons'
  alias ll='eza -lh --icons'
  alias la='eza -lAh --icons'
  alias lt='eza --tree --icons'
else
  alias l='ls -lah'
  alias ll='ls -lh'
  alias la='ls -lAh'
fi

# ===== PROJECT SHORTCUTS =====
alias dotfiles='cd ~/project/dotfiles'
alias projects='cd ~/project'

# ===== YAZI (cd to last yazi cwd on exit) =====
yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
alias y='yazi'
