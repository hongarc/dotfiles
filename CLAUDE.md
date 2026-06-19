# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory represents a stow package that mirrors the target file structure (usually `~`).

## Commands

```bash
# Apply all configurations to home directory
./stow-all.sh

# Apply specific package
stow zsh
stow tmux
stow neovim

# Remove a package
stow -D zsh

# Dry run (preview changes)
stow -n zsh
```

The `.stowrc` file sets `--target=~` and ignores `.DS_Store`/`Thumbs.db` by default.

## Structure

```
dotfiles/
├── zsh/          # Shell: .zshrc, .zsh_plugins.txt, starship.toml
├── tmux/         # Tmux config with Catppuccin theme
├── neovim/       # LazyVim-based Neovim config
├── lazygit/      # LazyGit TUI config
├── yazi/         # Yazi file manager config
└── yabai/        # Yabai window manager + skhd hotkeys (macOS)
```

## Key Configurations

### Zsh (`zsh/`)
- Uses **Antidote** plugin manager with plugins defined in `.zsh_plugins.txt`
- **Starship** prompt configured in `.config/starship.toml`
- Key plugins: fzf-tab, zoxide, zsh-autosuggestions, zsh-syntax-highlighting
- FZF completion trigger: `//`

### Neovim (`neovim/`)
- Based on **LazyVim** starter template
- Entry point: `init.lua` → `lua/config/lazy.lua`
- Custom plugins in `lua/plugins/`
- Custom keymaps in `lua/config/keymaps.lua`

### Tmux (`tmux/`)
- Entry: `.tmux.conf` sets prefix then sources four modules from `.config/tmux/`:
  - `options.conf` — server/session/window options (terminal, mouse, history, focus-events, base-index, etc.)
  - `theme.conf` — Catppuccin (frappe) + status bar
  - `keys.conf` — all bindings (splits, pane nav, resize, window switch, reload, copy-mode)
  - `plugins.conf` — plugin env vars + `run` loaders
- Plugins: catppuccin, tmux-cpu, tmux-battery, tmux-fzf
- Status bar at top: session (left), application + cpu (right)
- Prefix: `Ctrl-m`
- **Colemak keyboard layout** bindings: hnei instead of hjkl
- Key bindings:
  - Split (open in current path): `|` horizontal, `-` vertical, `c` new window
  - Pane navigation: `h/n/e/i` (Colemak)
  - Pane resize (repeatable): `H/N/E/I`
  - Window switching: `u/y` (next/previous)
  - tmux-fzf menu: `f` (popup)
  - Reload config: `r`
- Copy mode: vi-style with Colemak navigation, `v` to select, `y` copies via `pbcopy`
- Windows/panes start at index 1

### Colemak Navigation Note

This setup uses **Colemak keyboard layout** navigation keys throughout:
- `h/n/e/i` replaces `h/j/k/l` for left/down/up/right
- This applies to tmux pane navigation, copy mode, and vim-style keybindings

## Git Submodules

Tmux plugins are git submodules. After cloning:
```bash
git submodule update --init --recursive
```

## Harness: Dotfiles Consistency

**Goal:** Keep theme, keybindings, and bootstrap consistent across all tools (tmux, zsh, neovim, lazygit, lazydocker, yazi, btop, hyprland).

**Trigger:** For any cross-tool consistency request (make configs consistent, theme/keybinding consistency, audit my dotfiles, re-run the consistency check), use the `dotfiles-consistency` skill. Simple single-tool questions can be answered directly. Single-nvim-plugin asks → `polaron`; applying one known edit → `quark`/`/implement`.

**Reviewers:** `theme-reviewer` (Catppuccin frappe uniformity), `keybind-reviewer` (Colemak `hnei` parity), `repro-reviewer` (stow/submodules/lockfiles/hygiene). All read-only; fixes route to `quark`.

**Changelog:**
| Date | Change | Target | Reason |
|------|--------|--------|--------|
| 2026-06-19 | Initial build (lean harness) | agents/{theme,keybind,repro}-reviewer, skills/dotfiles-consistency | reuse global dotfiles-audit; add parallel per-dimension reviewers + orchestrator |
