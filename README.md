# 🏠 Dotfiles

Configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/) for clean dotfiles management.

## 📁 Structure

Each application has its own directory that mirrors the target file structure:

```
dotfiles/
├── zsh/                    # → ~/.zshrc, ~/.zsh_plugins.txt
├── tmux/                   # → ~/.config/tmux/
├── neovim/                 # → ~/.config/nvim/
├── lazygit/                # → ~/.config/lazygit/
└── stow-all.sh             # Apply all configs
```

## 🚀 Quick Start

### Install Stow
```bash
# macOS
brew install stow

# Linux
sudo apt install stow  # Ubuntu/Debian
sudo pacman -S stow    # Arch
```

### Apply Configurations
```bash
# Apply all
./stow-all.sh

# Apply specific
stow zsh
stow tmux
stow neovim
```

## 🔧 How It Works

Stow creates symbolic links from your dotfiles to your home directory.

**Example:**
```
dotfiles/tmux/.config/tmux/keys.conf
```
Running `stow tmux` creates:
```
~/.config/tmux/keys.conf → /path/to/dotfiles/tmux/.config/tmux/keys.conf
```

## 📋 What's Included

- **🐚 Zsh**: Antidote plugins, Starship prompt, smart completions
- **🎭 Tmux**: Custom navigation and keybindings
- **🖥️ Neovim**: Plugin management and settings
- **📊 LazyGit**: Git TUI customization

## 🛠️ Useful Commands

```bash
# Apply config to home directory
stow zsh

# Apply config to specific target directory
stow -t ~ zsh

# Remove config
stow -D zsh

# Dry run (see what would happen)
stow -n zsh

# Verbose output (see what's happening)
stow -v zsh

# Verbose dry run (see what would happen in detail)
stow -vn zsh
```

## 🔄 Workflow

1. **Edit** config files in this repo
2. **Commit** changes: `git add . && git commit -m "update config"`
3. **Apply**: `stow zsh` (or whatever you changed)

---

**Happy configuring! 🎉**
