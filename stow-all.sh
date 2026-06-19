#!/usr/bin/env bash
set -euo pipefail

# Warn if tmux is too old for this config (needs >= 3.3; Amazon Linux 2 ships 1.8).
if command -v tmux >/dev/null 2>&1; then
  tmux_ver=$(tmux -V | sed -E 's/tmux ([0-9.]+).*/\1/')
  if [ "$(printf '%s\n3.3\n' "$tmux_ver" | sort -V | head -1)" != "3.3" ]; then
    echo "WARNING: tmux $tmux_ver < 3.3 — config uses allow-passthrough/%if/Catppuccin." >&2
    echo "         Build a newer tmux from source; see tmux/README.md." >&2
  fi
fi

# Ensure tmux plugins (and any other submodules) are present on a fresh clone
git submodule update --init --recursive

# Re-stow all packages (idempotent: -R removes then re-creates symlinks)
# */  auto-discovers every top-level directory as a stow package
stow -Rt ~ */
