# ---- System PATH Configuration ----
# If you come from Bash, you may need to modify your $PATH.
# Add custom directories to the system PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# ---- Oh My Zsh Configuration ----
# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# ---- Theme Configuration ----
# Set the theme for Oh My Zsh
# Use "random" to load a random theme on each session
ZSH_THEME="awesomepanda"

# ---- Completion Configuration ----
# Enable case-sensitive completion (default is case-insensitive)
# Uncomment to enable case-sensitive completion
# CASE_SENSITIVE="true"

# Enable hyphen-insensitive completion (if CASE_SENSITIVE is off)
# Uncomment to enable hyphen-insensitive completion
# HYPHEN_INSENSITIVE="true"

# ---- Auto-Update Configuration ----
# Choose auto-update behavior for Oh My Zsh
# Uncomment one of the following lines to change the update mode
# zstyle ':omz:update' mode disabled   # Disable automatic updates
# zstyle ':omz:update' mode auto       # Update automatically without asking
# zstyle ':omz:update' mode reminder   # Show a reminder to update when needed

# Set the frequency for auto-update (in days)
# Uncomment and set the frequency if desired
# zstyle ':omz:update' frequency 13

# ---- Plugin Configuration ----
# Load plugins for Oh My Zsh. Too many plugins may slow down startup.
plugins=(
  git                # Git plugin for Zsh
  gh                 # GitHub CLI plugin
  git-auto-fetch     # Automatically fetch updates from Git remotes
  zsh-autosuggestions # Auto-suggestions for commands
  zsh-syntax-highlighting # Syntax highlighting for commands
  fzf-tab            # Fuzzy tab completion
  zoxide             # Faster `cd` with auto-jumping
  terraform          # Terraform CLI plugin
)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# ---- User Configuration ----
# Set language environment if needed (uncomment and set as needed)
# export LANG=en_US.UTF-8

# Set compilation flags (uncomment if required for specific builds)
# export ARCHFLAGS="-arch $(uname -m)"

# ---- LM Studio CLI Configuration ----
# Add LM Studio CLI binaries to PATH
export PATH="$PATH:$HOME/.cache/lm-studio/bin"

# ---- Bun Configuration ----
# If Bun is installed, load Bun completion script
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Set Bun installation directory and add to PATH
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ---- Starship Prompt Initialization (Optional) ----
# Uncomment to initialize the Starship prompt if you're using it
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
else
  echo "Starship is not installed. Please install it first."
fi

# ---- The Fuck Configuration ----
# Enable The Fuck command alias for correcting previous commands
eval $(thefuck --alias f)

# ---- FZF Configuration ----
# Set FZF trigger key and source the FZF completions
export FZF_COMPLETION_TRIGGER='//'
source <(fzf --zsh)



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
