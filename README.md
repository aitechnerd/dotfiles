# dotfiles — chezmoi

macOS configuration managed with [chezmoi](https://www.chezmoi.io/). One command to set up everything.

## What This Manages

- **CLI tools**: git, ripgrep, fd, bat, fzf, eza, zoxide, delta, mc, etc. (via Homebrew)
- **GUI apps**: Zed, Ghostty, DBeaver, etc. (via Homebrew casks)
- **Shell**: zsh with aliases, autosuggestions, syntax highlighting, direnv
- **Git**: delta diffs, global gitignore, machine-specific email
- **Editor**: Zed settings, Tileport window manager config
- **macOS settings**: dark mode, fast key repeat, Dock auto-hide, Siri disabled, Touch ID sudo

## Fresh Machine Setup

```bash
# 1. Install Homebrew (also installs Xcode CLT which provides git)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# 2. Clone the repo (git is now available via Xcode CLT)
git clone https://github.com/aitechnerd/dotfiles.git ~/.dotfiles

# 3. Install chezmoi and apply
brew install chezmoi
chezmoi init --source=~/.dotfiles --apply
```

chezmoi will prompt for machine type (`personal` or `work`) on first run, then:
- Install all Homebrew packages and casks
- Apply macOS system defaults
- Symlink all config files

The repo stays at `~/.dotfiles` — edit files there, commit, push as normal.

### Manual steps (one-time)

- System Settings -> Accessibility -> Display -> Reduce Motion -> ON
- System Settings -> Accessibility -> Display -> Reduce Transparency -> ON
- System Settings -> Privacy & Security -> Analytics & Improvements -> turn off all sharing
- Disable Spotlight indexing: `sudo mdutil -a -i off`

## Daily Usage

```bash
# Apply config changes after editing files in ~/.dotfiles
chezmoi apply

# See what would change
chezmoi diff

# Pull changes from actual files (e.g. ~/.gitconfig) back into the repo
chezmoi re-add

# Commit and push
cd ~/.dotfiles && git add -A && git commit -m "update configs" && git push
```

### Add a CLI tool -> edit `Brewfile` -> `chezmoi apply`

### Add a GUI app -> edit `Brewfile` -> `chezmoi apply`

### Change a macOS default -> edit `run_onchange_macos.sh` -> `chezmoi apply`

### On another machine

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
git clone https://github.com/aitechnerd/dotfiles.git ~/.dotfiles
brew install chezmoi
chezmoi init --source=~/.dotfiles --apply
```

## Structure

```
├── .chezmoi.toml.tmpl          # Machine config (personal/work prompt)
├── Brewfile                    # Homebrew packages and casks
├── run_onchange_brew.sh.tmpl   # Installs Homebrew packages when Brewfile changes
├── run_onchange_macos.sh       # macOS defaults, Touch ID sudo, system tweaks
├── dot_zshrc.tmpl              # zsh config (aliases, plugins, env vars)
├── dot_gitconfig.tmpl          # git config (templated for personal/work email)
├── dot_gitignore_global        # global gitignore
└── private_dot_config/
    ├── zed/settings.json       # Zed editor config
    └── tileport/tileport.toml  # Tileport window manager config
```

## Machine-Specific Config

The `.chezmoi.toml.tmpl` prompts for `type` on init (`personal` or `work`). Templates use this to vary config — for example, `dot_gitconfig.tmpl` sets different email addresses per machine type.
