# Dotfiles

Configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Packages

```
dotfiles/
├── zsh/          # .zshrc, .zsh_plugins.txt, starship.toml — Antidote + Starship
├── tmux/         # Catppuccin Frappé theme, Colemak bindings, Ctrl-m prefix
├── neovim/       # LazyVim-based config with custom plugins and keymaps
├── lazygit/      # Git TUI — Frappé palette, Colemak keybindings
├── lazydocker/   # Docker TUI — Frappé palette
├── yazi/         # File manager — Frappé theme
├── btop/         # System monitor config
├── hyprland/     # Wayland compositor bundle (Fedora) — see hyprland/README.md
└── stow-all.sh   # Apply all packages at once
```

## Fresh machine bootstrap

```bash
# 1. Clone
git clone https://github.com/hongarc/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 2. Pull submodules (tmux plugins, etc.)
git submodule update --init --recursive

# 3. Install tools
brew bundle --file=Brewfile

# 4. Link configs into home directory
./stow-all.sh
```

## Stow commands

```bash
# Apply all packages (idempotent)
./stow-all.sh

# Apply or re-apply a single package
stow -Rt ~ zsh

# Remove a package's symlinks
stow -Dt ~ zsh

# Dry run — preview what would change
stow -nRt ~ zsh
```

## Key details

- **Keyboard layout:** Colemak — navigation keys are `h/n/e/i` instead of `h/j/k/l`
- **Theme:** Catppuccin Frappé throughout (tmux, lazygit, lazydocker, yazi)
- **Tmux prefix:** `Ctrl-m`
- **FZF completion trigger:** `//`
- **Plugin manager:** Antidote (zsh), LazyVim/Lazy.nvim (neovim)
