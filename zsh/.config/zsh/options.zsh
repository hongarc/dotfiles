# ZSH_CACHE_DIR — required by ohmyzsh plugins (e.g. docker) loaded via Antidote.
# Without this, the docker plugin writes to /completions/_docker (broken path).
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p "$ZSH_CACHE_DIR/completions"

# ===== HISTORY =====
HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
HISTSIZE=100000   # in-memory lines (bumped for DevOps long-lived shells)
SAVEHIST=100000   # on-disk lines

setopt EXTENDED_HISTORY          # ":start:elapsed;command" format
setopt INC_APPEND_HISTORY        # write immediately, not on shell exit
setopt SHARE_HISTORY             # share across all sessions
setopt HIST_EXPIRE_DUPS_FIRST    # expire dups first when trimming
setopt HIST_IGNORE_DUPS          # don't record consecutive dups
setopt HIST_IGNORE_ALL_DUPS      # delete old entry if new one is a dup
setopt HIST_FIND_NO_DUPS         # don't display dups during search
setopt HIST_SAVE_NO_DUPS         # don't write dups to history file
setopt HIST_REDUCE_BLANKS        # strip superfluous blanks
setopt HIST_VERIFY               # don't auto-execute on history expansion
setopt HIST_IGNORE_SPACE         # commands starting with space are private

# ===== DIRECTORY NAVIGATION =====
setopt AUTO_CD                   # `myfolder` == `cd myfolder`
setopt AUTO_PUSHD                # cd pushes onto dir stack
setopt PUSHD_IGNORE_DUPS         # no dup entries in dir stack
setopt PUSHD_SILENT              # don't print stack after pushd/popd
setopt PUSHD_MINUS               # swap meaning of `cd +N` and `cd -N`

# ===== GLOBBING & MATCHING =====
setopt EXTENDED_GLOB             # **/, ^(foo), <1-10> globs
setopt GLOB_DOTS                 # include dotfiles in globs
setopt NO_CASE_GLOB              # case-insensitive globbing
setopt NUMERIC_GLOB_SORT         # file2 before file10

# ===== COMPLETION BEHAVIOR =====
setopt COMPLETE_IN_WORD          # complete from cursor, not end of word
setopt ALWAYS_TO_END             # move cursor to end after completion

# ===== SAFETY & UX =====
setopt INTERACTIVE_COMMENTS      # allow `# comments` at the prompt
setopt NO_BEEP                   # shut up
setopt NO_FLOW_CONTROL           # disable Ctrl-S / Ctrl-Q freeze

# ===== ZSH-AUTOSUGGESTIONS (must be set before the plugin is sourced) =====
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
