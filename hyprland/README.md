# 🪟 Hyprland Desktop Bundle

Wayland desktop for Fedora — Hyprland compositor + Waybar + SwayNotificationCenter (swaync) + fuzzel + hyprlock + hypridle + swww + wlogout + pyprland.

**Theme:** Catppuccin Frappé · **Font:** CaskaydiaCove Nerd Font · **Layout:** Colemak (HNEI)

## 📁 Package contents

```
hyprland/.config/
├── hypr/
│   ├── hyprland.conf        # main compositor config
│   ├── hypridle.conf        # idle dim/lock/dpms/suspend
│   ├── hyprlock.conf        # lock screen UI
│   ├── pyprland.toml        # scratchpads (drop-down term/files/music)
│   ├── scripts/             # all helper scripts (see below)
│   └── wallpapers/          # 14 Catppuccin wallpapers + random rotation
├── waybar/                  # top bar — minimal GNOME-style
├── swaync/                  # notification center w/ side panel + DND + buttons
├── wlogout/                 # full-screen power menu
└── fuzzel/                  # app launcher
```

## 📦 Required Fedora packages

```bash
# Compositor + lock + idle (most live in copr:solopasha/hyprland)
sudo dnf install hyprland hyprlock hypridle

# Bar / launcher / notifications / power menu
sudo dnf install waybar fuzzel SwayNotificationCenter wlogout

# Wallpaper, screenshots, clipboard, color picker
sudo dnf install swww hyprshot hyprpicker grim slurp wl-clipboard cliphist

# Scratchpads + system utilities
sudo dnf install pyprland pavucontrol polkit-gnome lm_sensors btop nwg-look

# Misc
sudo dnf install playerctl google-chrome-stable
```

Font (already installed in `~/.local/share/fonts/`): **CaskaydiaCove Nerd Font** (Regular, Bold, Italic).

## 🔧 Apply

```bash
stow hyprland           # from repo root, creates ~/.config symlinks
hyprctl reload          # if Hyprland is running
```

Stow tree-folds these directories:
```
~/.config/hypr    → hyprland/.config/hypr
~/.config/waybar  → hyprland/.config/waybar
~/.config/swaync  → hyprland/.config/swaync
~/.config/wlogout → hyprland/.config/wlogout
~/.config/fuzzel  → hyprland/.config/fuzzel
```

## 🎨 Frappé palette

| Role | Hex | Used for |
|---|---|---|
| Base | `#303446` | window backgrounds |
| Mantle | `#292c3c` | tooltips, lock screen |
| Surface 0/1/2 | `#414559` / `#51576d` / `#626880` | pills, hover states |
| Text | `#c6d0f5` | primary text |
| Subtext | `#a5adce` / `#b5bfe2` | secondary |
| Blue | `#8caaee` | accent / focus / active workspace |
| Mauve | `#ca9ee6` | gradient pair |
| Green | `#a6d189` | success / network / mpris |
| Red | `#e78284` | critical / power |
| Yellow / Peach / Pink | `#e5c890` / `#ef9f76` / `#f4b8e4` | misc colors |

Window borders use a 45° **blue → mauve** gradient when focused, surface0 when not.

## ⌨️ Keybindings

`SUPER` = Mod key. Layout is **Colemak** — directional keys are `H N E I`.

### Apps
| Key | Action |
|---|---|
| `SUPER + Return` | ghostty |
| `SUPER + C` | Google Chrome |
| `SUPER + R` | fuzzel launcher |
| `SUPER + A` | pavucontrol (audio) |
| `SUPER + L` | hyprlock (lock screen) |
| `SUPER SHIFT + L` | wlogout (full-screen power menu) |
| `SUPER + M` | toggle mic-monitor (hear yourself in headphones) |
| `SUPER + K` | hyprpicker (color picker, copies hex) |
| `SUPER + \` | toggle swaync notification panel |
| `SUPER + X` | clipboard history (cliphist + fuzzel) |

### Pyprland scratchpads (Quake-style drop-down)
| Key | Action |
|---|---|
| `SUPER + T` | drop-down ghostty terminal |
| `SUPER + Y` | drop-down yazi file manager |
| `SUPER + U` | drop-down music slot |

### Window management
| Key | Action |
|---|---|
| `SUPER + Q` | close active window |
| `SUPER + V` | toggle floating |
| `SUPER + F` | fullscreen |
| `SUPER + P` | pseudo-tile |
| `SUPER + J` | toggle split direction |
| `SUPER + D` | toggle "show desktop" (special workspace `hidden`) |
| `SUPER SHIFT + D` | move window to hidden workspace |
| `SUPER SHIFT + M` | exit Hyprland |

### Focus / cycle within workspace
| Key | Action |
|---|---|
| `SUPER + Tab` | next window |
| `SUPER SHIFT + Tab` | previous window |
| `` SUPER + ` `` | toggle last 2 (Alt-Tab style) |
| `SUPER + H/N/E/I` | focus right / left / down / up |

### Move windows
| Key | Action |
|---|---|
| `SUPER SHIFT + H/N/E/I` | move window right / left / down / up |

### Workspaces
| Key | Action |
|---|---|
| `SUPER + 1..0` | switch to workspace 1..10 |
| `SUPER SHIFT + 1..0` | move active window to workspace |
| Mouse 4 / 5 (side buttons) | prev / next existing workspace |

Per-monitor pinning: workspaces 1–5 live on **DP-4**, 6–10 on **HDMI-A-4**.

### Multi-monitor focus
| Key | Action |
|---|---|
| `SUPER + ,` / `.` | focus DP-4 / HDMI-A-4 |
| `SUPER SHIFT + ,` / `.` | move window to DP-4 / HDMI-A-4 |

### Wallpaper rotation
| Key | Action |
|---|---|
| `SUPER + W` | random wallpaper |
| `SUPER SHIFT + W` | next wallpaper (alphabetical) |
| `SUPER CTRL + W` | previous wallpaper |

A toast pops up showing the new wallpaper's filename.

### Screenshots (hyprshot)
| Key | Action |
|---|---|
| `Print` | region → file + clipboard |
| `SHIFT + Print` | full screen → file + clipboard |
| `SUPER + Print` | active window → file + clipboard |
| `CTRL + Print` | region → clipboard only (no save) |

Submap mode for less hand contortion:
| Key | Action |
|---|---|
| `SUPER + S` then `r` | region |
| `SUPER + S` then `w` | window |
| `SUPER + S` then `f` | full screen |
| `SUPER + S` then `Esc` | exit submap |

Files are saved to `~/Pictures/Screenshots/`.

### Mouse drag
| Key | Action |
|---|---|
| `SUPER + LMB` | move window |
| `SUPER + RMB` | resize window |

### Media keys
- Volume up / down / mute → `wpctl`
- Mic mute → `wpctl`
- (Brightness keys removed — desktop has no backlight)

## 📊 Waybar layout (top bar)

```
[ workspaces ]  [ window title ]  ·  [ mpris if playing ]      |     [ Sat 02 May  09:05 ]     |     [ ⛅ 31°C ]  [  810 ]  [  Vol 45% ]  [  LAN ]  [  Notif ]  [ tray ]  [ ⏻ ]
```

| Module | Click actions |
|---|---|
| **Workspaces** | left = activate; scroll = next/prev existing |
| **Clock** | right-click = cycle timezones (HCM → UTC → NY → London → Tokyo) |
| **Weather** | wttr.in (Da Nang, refreshes every 30 min); click = open in browser |
| **Updates** | dnf check-update count; left = upgrade in ghostty; right = list only |
| **Volume** | left = pavucontrol; right = mute; scroll = ±5% |
| **Network** | shows LAN/WiFi/offline; click = nmtui in ghostty |
| **Notifications** | left = open swaync panel; right = toggle DND |
| **Power** ⏻ | fuzzel power menu (Lock / Logout / Suspend / Reboot / Shutdown) |
| **mpris** | left = play/pause; mid = prev; right = next; hidden when stopped |

## 🌙 Idle / lock / sleep (hypridle)

| Idle time | Action |
|---|---|
| 5 min | (dim — only effective on laptops with backlight) |
| 10 min | lock screen (hyprlock) |
| 15 min | turn screen off (DPMS) |
| 30 min | suspend (`systemctl suspend`) |

Lock screen UI: Frappé palette, blurred wallpaper, large clock + date + username + password input.

## 🖼️ Wallpaper system

- 14 wallpapers shipped in `hyprland/.config/hypr/wallpapers/`
- Random pick on every login (via `wallpaper.sh` exec-once)
- Hotkey rotation (see keybinds above)
- Add your own: just drop `.jpg` / `.png` files in the wallpapers dir
- State: `~/.cache/swww-current` holds the path of the currently-set wallpaper

To enable **per-workspace random** (auto-randomize on every workspace change):
```bash
~/.config/hypr/scripts/wallpaper.sh watch &
```
Or add to `hyprland.conf`:
```
exec-once = ~/.config/hypr/scripts/wallpaper.sh watch
```

## 🛠️ Helper scripts

All in `hyprland/.config/hypr/scripts/`:

| Script | Purpose |
|---|---|
| `wallpaper.sh` | random / next / prev / set / watch — swww driver |
| `power-menu.sh` | fuzzel-driven power menu (Lock / Logout / Suspend / Reboot / Shutdown) |
| `mic-monitor.sh` | toggle pw-loopback for hear-yourself in headphones |
| `notifications.sh` | mako-era notification picker (legacy fallback) |
| `weather.sh` | wttr.in JSON for waybar (defaults to Da Nang) |
| `updates.sh` | dnf check-update count for waybar |
| `run-update.sh` | `sudo dnf upgrade` runner with hold-open prompt |
| `cpu-temp-watch.sh` | live `coretemp` reader (no lm_sensors dependency) |

## 🔔 Quick tests

```bash
# Daemons
pgrep -a waybar swaync swww-daemon pypr hypridle

# Notifications
notify-send "Test" "swaync"
notify-send -u critical "Critical" "stays until dismissed"
swaync-client -t -sw           # toggle panel
swaync-client -d -sw           # toggle DND

# Wallpaper
~/.config/hypr/scripts/wallpaper.sh        # random
swww query                                 # current state

# Lock screen
hyprlock                                   # lock now
hyprctl dispatch dpms off                  # screen off

# Bar
pkill -SIGUSR2 waybar                      # reload bar
hyprctl reload                             # reload Hyprland
```

## ✏️ Customization tips

- **Different city for weather:** edit `scripts/weather.sh` or change `"exec"` in waybar config
- **Different timezones:** edit `clock.timezones` array in waybar config
- **Add wallpapers:** drop into `wallpapers/`, hit `SUPER+W` to randomize
- **Adjust border colors:** `general { col.active_border = ... }` in `hyprland.conf`
- **Change idle timeouts:** edit `hypridle.conf` listener blocks
- **Change accent color:** swap `#8caaee` (Frappé Blue) globally — it's used in waybar style.css, swaync, hyprlock, hyprland.conf borders

## 🐛 Known limitations

- Brightness keys do nothing (no laptop backlight on this machine)
- Touchpad gesture binds removed (no touchpad)
- DP-4 monitor binds exist in config but DP-4 is not currently connected
- 5-min "dim" idle step is a no-op without a backlight
