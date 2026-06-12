#!/usr/bin/env bash
set -euo pipefail

# Ensure tmux plugins (and any other submodules) are present on a fresh clone
git submodule update --init --recursive

# Re-stow all packages (idempotent: -R removes then re-creates symlinks)
# */  auto-discovers every top-level directory as a stow package
stow -Rt ~ */
