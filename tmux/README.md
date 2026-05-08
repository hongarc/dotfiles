# Tmux config

Modular tmux configuration with Catppuccin theme, Colemak navigation, and a small set of plugins.

## Layout

```
tmux/
├── .tmux.conf                 # entry: prefix + sources modules
└── .config/tmux/
    ├── options.conf           # server/session/window options
    ├── theme.conf             # Catppuccin + status bar
    ├── keys.conf              # all keybindings
    ├── plugins.conf           # plugin env vars + run loaders
    └── plugins/               # git submodules
        ├── catppuccin/tmux
        ├── tmux-plugins/tmux-cpu
        ├── tmux-plugins/tmux-battery
        └── tmux-fzf
```

Source order: `options → theme → keys → plugins`. Plugins load last so they see final option values.

## Install

```bash
# from the dotfiles repo root
git submodule update --init --recursive
stow tmux
```

Requires `fzf` on PATH (`brew install fzf`) for the tmux-fzf menu.

## Prefix

`Ctrl-m`

> Note: `Ctrl-m` is the same byte as Enter in most terminals. If you hit weird behavior, switch to `Ctrl-Space` or `Ctrl-a` in `.tmux.conf`.

## Keybindings

All keys assume the Colemak layout — `h/n/e/i` = left/down/up/right.

### Panes & windows
| Key | Action |
| --- | --- |
| `\|` | Split horizontal (new pane right, current path) |
| `-` | Split vertical (new pane below, current path) |
| `c` | New window (current path) |
| `h n e i` | Move between panes |
| `H N E I` | Resize panes (repeatable) |
| `u` / `y` | Next / previous window |
| `f` | tmux-fzf menu (popup) |
| `r` | Reload config |

### Copy mode (vi)
| Key | Action |
| --- | --- |
| `h n e i` | Cursor left/down/up/right |
| `v` | Begin selection |
| `y` | Copy selection to system clipboard (`pbcopy`) |
| mouse drag | Auto-copy on release |

## Theme & status

Catppuccin **frappe**, status bar at top.
- Left: session
- Right: application + CPU

Battery module is wired but commented; uncomment in `theme.conf` to enable.

## Plugins

Loaded from `plugins.conf`:
- [catppuccin/tmux](https://github.com/catppuccin/tmux)
- [tmux-plugins/tmux-cpu](https://github.com/tmux-plugins/tmux-cpu)
- [tmux-plugins/tmux-battery](https://github.com/tmux-plugins/tmux-battery)
- [sainnhe/tmux-fzf](https://github.com/sainnhe/tmux-fzf)

tmux-fzf is configured in `plugins.conf`:
```
TMUX_FZF_LAUNCH_KEY="f"
TMUX_FZF_OPTIONS="-p -w 80% -h 60% -m"
TMUX_FZF_ORDER="session|window|pane|command|keybinding|clipboard|process"
```

## Adding / removing things

- **New option** → `options.conf`
- **New keybind** → `keys.conf`
- **Theme tweak** → `theme.conf`
- **New plugin** →
  1. `git submodule add <url> tmux/.config/tmux/plugins/<name>`
  2. Add `run ~/.config/tmux/plugins/<name>/<entry>.tmux` to `plugins.conf`
