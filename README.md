# dotfiles — nix-darwin + home-manager

Declarative macOS configuration. One command to set up everything.

## What This Manages

- **CLI tools**: git, ripgrep, fd, bat, fzf, eza, zoxide, delta, mc, etc. (via Homebrew)
- **GUI apps**: Zed, Ghostty, DBeaver, etc. (via Homebrew casks)
- **Shell**: zsh with aliases, autosuggestions, syntax highlighting, direnv
- **Git**: delta diffs, global gitignore
- **Editor**: Zed settings as a mutable config file (`config/zed/settings.json`)
- **macOS settings**: dark mode, fast key repeat, Dock auto-hide, Siri disabled, Touch ID sudo
- **Automation**: daily brew upgrades (2am via launchd), weekly Nix garbage collection

## Before You Start

1. `home/git.nix` → set your git `settings.user.name` and `settings.user.email`
2. Username and hostname are auto-detected (uses `--impure` flag)

## Fresh Machine Setup

### 1. Install Nix (Determinate)

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

Restart your terminal after installation.

### 2. Install Homebrew (required for CLI tools and GUI apps)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 3. Clone and apply

```bash
git clone https://github.com/aitechnerd/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

First run uses `nix run` to bootstrap nix-darwin:

```bash
sudo nix run nix-darwin -- switch --flake . --impure
```

### 4. Manual steps (one-time)

- System Settings → Accessibility → Display → Reduce Motion → ON (replaces slide animations with instant cross-fades system-wide)
- System Settings → Accessibility → Display → Reduce Transparency → ON (less compositing overhead)
- Verify Siri is off (may need logout): System Settings → Siri & Spotlight
- Disable Spotlight indexing (saves CPU, replace with Raycast/Alfred): `sudo mdutil -a -i off`
- Disable Time Machine local snapshots (if not using Time Machine): `sudo tmutil disable`
- Disable Game Center daemon (~30MB): `launchctl bootout gui/$(id -u) /System/Library/LaunchAgents/com.apple.gamed.plist 2>/dev/null`
- Disable Siri Knowledge agent (~50MB): `launchctl bootout gui/$(id -u) /System/Library/LaunchAgents/com.apple.knowledge-agent.plist 2>/dev/null`
- Remove all widgets from Notification Center (each widget is a separate process)
- System Settings → Privacy & Security → Analytics & Improvements → turn off all sharing
- System Settings → General → AirDrop & Handoff → Handoff → OFF (if not using cross-device handoff)

## Daily Usage

After the initial install, nix-darwin is available directly:

```bash
rebuild                                        # rebuild after config changes (shell alias)
darwin-rebuild switch --flake . --impure       # same thing, explicit form
darwin-rebuild switch --rollback               # rollback to previous config
```

Brew packages are upgraded automatically daily at 2am (runs on wake if laptop was asleep). To upgrade manually:

```bash
brew upgrade
```

### Update all inputs (nixpkgs, home-manager, nix-darwin)

```bash
cd ~/.dotfiles
nix flake update
rebuild
```

### Add a CLI tool → `modules/homebrew.nix` (brews) → `rebuild`

### Add a GUI app → `modules/homebrew.nix` (casks) → `rebuild`

### Edit Zed settings → `config/zed/settings.json` → commit and push

## Structure

```
├── flake.nix              # Entry point — inputs, outputs, username/hostname auto-detected
├── hosts/
│   └── air-m4.nix         # Machine identity, user, nix settings
├── modules/
│   ├── system.nix         # macOS defaults, launchd agents, Nix GC
│   ├── packages.nix       # Nix-only packages (fonts, Nix tools)
│   └── homebrew.nix       # CLI tools (brews) and GUI apps (casks)
├── config/
│   └── zed/
│       └── settings.json  # Zed editor config (mutable, edit directly)
└── home/
    ├── default.nix        # home-manager: Zed symlink, session vars
    ├── shell.nix          # zsh: aliases, history, direnv
    └── git.nix            # git: config, delta, gh CLI
```
