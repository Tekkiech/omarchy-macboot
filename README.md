# macOS Boot Switch (`tekkiech.macboot`)

An [Omarchy](https://omarchy.org) bar-widget plugin that wraps
[`asahi-bless`](https://github.com/AsahiLinux/asahi-bless) so switching back
to macOS on Asahi Linux is a couple of clicks instead of a terminal command.

## What it does

Adds a single icon to the Omarchy bar. Clicking it opens a small floating
terminal that:

1. Lists your boot volumes via `asahi-bless --list-volumes`
2. Offers a menu (via [`gum`](https://github.com/charmbracelet/gum)):
   - **Set next boot to macOS (no reboot)** — sets the boot target and lets
     you reboot whenever you're ready
   - **Reboot into macOS now** — sets the boot target and immediately
     `systemctl reboot`s
   - **Cancel**

Each destructive action has its own `gum confirm` prompt before it runs.
`asahi-bless` needs root to touch nvram, so both actions run under `pkexec`
and will prompt for your password via the normal polkit dialog.

## Requirements

- An Asahi Linux install (Apple Silicon Mac) running Omarchy
- `asahi-bless` on `PATH` (ships with Asahi Linux)
- `gum` on `PATH` (ships with Omarchy)

## Install

```bash
omarchy plugin add https://github.com/Tekkiech/omarchy-macboot.git --enable
```

Or manually:

```bash
git clone https://github.com/Tekkiech/omarchy-macboot.git ~/.config/omarchy/plugins/tekkiech.macboot
omarchy plugin enable tekkiech.macboot
```

## Files

- `manifest.json` — plugin manifest (`bar-widget` kind)
- `BarWidget.qml` — the bar icon; clicking it shells out to `bin/macboot`
  inside a floating terminal
- `bin/macboot` — the interactive picker script
