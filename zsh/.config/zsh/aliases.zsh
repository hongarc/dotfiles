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

# ===== EDITOR =====
alias v='nvim'

# ===== LISTING (eza if available, ls fallback) =====
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons --group-directories-first'
  alias l='eza -lah --icons --group-directories-first --git'
  alias ll='eza -lh --icons --group-directories-first --git'
  alias la='eza -lAh --icons --group-directories-first --git'
  alias lt='eza --tree --icons --level=2 --git-ignore'
else
  alias l='ls -lah'
  alias ll='ls -lh'
  alias la='ls -lAh'
fi

# ===== SAFER DESTRUCTIVE OPS =====
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -pv'

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

# =============================================================================
# ===== DOCKER =====
# =============================================================================
# NOTE: many of the aliases below are ALSO defined by the ohmyzsh
# docker/docker-compose plugins loaded via Antidote.
# Where the omz plugin and this file define the same alias identically, this
# file simply re-declares it (harmless, explicit, easy to customise).
# Aliases that omz already covers are noted inline so you know where to look
# for the full set: ~/.antidote/.../plugins/<name>/<name>.plugin.zsh

# ----- Docker -----
# omz docker plugin covers: dps dpsa di dex dlog dprune (and defines `d` as
# `docker` — we intentionally shadow that with our dir-stack d() below).
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias dlog='docker logs -f'
alias dprune='docker system prune -af'
alias dsp='docker stop'   # stop a container by name/id
alias drm='docker rm -f'  # force-remove a container

# ----- Docker Compose -----
# omz docker-compose plugin covers: dc dcu dcd dcl and more.
alias dc='docker compose'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcl='docker compose logs -f'
alias dcr='docker compose restart'
alias dcb='docker compose build'

# Restore the dir-stack `d` function that omz/docker shadows with `d=docker`.
# This file loads AFTER plugins (see .zshrc load order), so this wins.
unalias d 2>/dev/null
d() {
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -n 10
  fi
}
compdef _dirs d
