# dotfiles — nix-darwin + home-manager

Declarative macOS configuration. One command to set up everything.

## What This Manages

- **CLI tools**: git, ripgrep, fd, bat, fzf, eza, zoxide, delta, etc.
- **GUI apps**: Zed, Ghostty, DBeaver, etc. (via Homebrew)
- **Shell**: zsh with aliases, autosuggestions, syntax highlighting, direnv
- **Git**: delta diffs, global gitignore
- **Editor**: Zed settings managed declaratively
- **macOS settings**: dark mode, fast key repeat, Dock auto-hide, Siri disabled, Touch ID sudo

## Fresh Machine Setup

### 1. Install Nix (Determinate)

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

Restart your terminal after installation.

### 2. Install Homebrew (required for GUI apps)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 3. Clone and apply

```bash
git clone https://github.com/aitechnerd/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles
```

First run uses `nix run` to bootstrap nix-darwin:

```bash
sudo nix run nix-darwin -- switch --flake .
```

### 4. Manual steps (one-time)

- System Settings → Accessibility → Display → Reduce Motion → ON
- Verify Siri is off (may need logout): System Settings → Siri & Spotlight

## Daily Usage

After the initial install, nix-darwin is available directly:

```bash
rebuild                              # rebuild after config changes (shell alias)
darwin-rebuild switch --flake .      # same thing, explicit form
darwin-rebuild switch --rollback     # rollback to previous config
```

### Update all inputs (nixpkgs, home-manager, nix-darwin)

```bash
cd ~/Projects/dotfiles
nix flake update
rebuild
```

### Add a CLI tool → `modules/packages.nix` → `rebuild`

### Add a GUI app → `modules/homebrew.nix` → `rebuild`

## Structure

```
├── flake.nix              # Entry point — inputs and outputs
├── hosts/
│   └── air-m4.nix         # Machine identity, user, nix settings
├── modules/
│   ├── system.nix         # macOS defaults (Dock, Finder, Siri, keyboard)
│   ├── packages.nix       # CLI tools via Nix
│   └── homebrew.nix       # GUI apps via Homebrew casks
└── home/
    ├── default.nix        # home-manager: Zed config, session vars
    ├── shell.nix          # zsh: aliases, history, direnv
    └── git.nix            # git: config, delta, gh CLI
```

## Before You Start

1. `flake.nix` → verify `hostname` and `username`
2. `home/git.nix` → set your git `settings.user.name` and `settings.user.email`
