# Fedora major-release upgrade (e.g. 42 → 44)

Different machinery than `dnf upgrade`. Takes 30–60 min, requires a reboot, rewrites the system.

> Why this guide exists for the Hyprland package: the `solopasha/hyprland` COPR pins
> `qt6-qtbase` to a specific minor version (e.g. 6.9 on F42), so updates that try to
> bump qt6 deadlock until a major Fedora upgrade pulls fresh versions of everything.

## Pre-flight

1. **Commit dotfiles** — anything important on disk
2. **Free disk space** — need ~15 GB
   ```sh
   df -h /
   ```
3. **Confirm target release is out** — F44 is announced on fedoraproject.org

## Procedure

### 1. Refresh + upgrade what's possible (skip the qt6 conflict)

```sh
sudo dnf upgrade --refresh -y --exclude='qt6-*' --exclude='kf6-*' --exclude='hyprland-qt*' --exclude='gstreamer1-plugins-good-qt6' --exclude='fcitx5-qt*'
```

### 2. Install the system-upgrade plugin

```sh
sudo dnf install -y dnf-plugin-system-upgrade
```

### 3. Download the new release (~3–5 GB)

`--allowerasing` breaks the qt6 stalemate by removing incompatible packages that F44 will re-provide fresh:

```sh
sudo dnf system-upgrade download --releasever=44 --allowerasing
```

### 4. Reboot into the upgrade environment

Black screen with progress for ~20 min, then reboots again into F44:

```sh
sudo dnf system-upgrade reboot
```

## Post-upgrade — restore Hyprland stack

COPR repos auto-disable on major Fedora upgrades. Re-enable for the new release, disable any COPRs without F44 builds (e.g. `pgdev/ghostty`), and re-install everything:

```sh
sudo dnf copr enable solopasha/hyprland fedora-44-x86_64 -y
sudo dnf copr disable pgdev/ghostty -y
```

Then **re-install the full Hyprland stack** (`upgrade` won't work because the system-upgrade removed these packages):

```sh
sudo dnf install -y hyprland hyprland-qt-support hyprland-qtutils hyprlock hypridle swww waybar fuzzel SwayNotificationCenter wlogout pyprland hyprshot hyprpicker
```

Verify:

```sh
hyprctl version | head -2
which swww waybar fuzzel swaync hyprshot
```

## If the upgrade fails / you want to roll back

System-upgrade transactions are atomic — failure on step 4 leaves you on the old release.
If something goes wrong on step 3:

```sh
sudo dnf system-upgrade clean      # discard the downloaded upgrade
```

If the post-reboot upgrade halts, your old kernel is still in the GRUB menu — pick it.

## Useful commands afterwards

```sh
cat /etc/fedora-release            # confirm new release
sudo dnf autoremove                # clean up obsolete packages
sudo dnf clean all                 # purge old metadata
sudo journalctl --vacuum-time=2d   # trim systemd journal
```

## Common breakages

- **Hyprland fails to start** → re-install from re-enabled COPR (post-upgrade step above)
- **fcitx5 stops working** → re-run `fcitx5 -d` and check `~/.config/fcitx5/profile`
- **Display managers / login screen broken** → boot to TTY (Ctrl+Alt+F3), fix from there
- **Old kernels accumulate** → `sudo dnf remove $(dnf repoquery --installonly --latest-limit=-2 -q)`
