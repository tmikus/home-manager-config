# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Nix Home Manager configuration repository that sets up a portable, declarative development environment across macOS, Linux, and cloud desktops.

## Common Commands

```bash
# Apply configuration changes
home-manager switch

# Update channels and apply (uses alias defined in configuration.nix)
update_home_manager

# Clean up Nix store to free disk space
./clean-nix-store.sh
nix-store --gc

# Restore Nix after macOS updates
./restore-nix.sh
```

## Architecture

### Entry Point Chain

```
home.nix
    ↓
configuration.nix (orchestrates all modules, defines global settings)
    ↓
Individual modules (*.nix files)
```

### Module Organization

Each tool has its own module file following a consistent pattern:
- Simple configs: `<tool>.nix` (e.g., `git.nix`, `tmux.nix`)
- Complex configs: `<tool>/default.nix` with supporting files (e.g., `ghostty/`, `wezterm/`)

### Key Files

- `configuration.nix` - Main orchestrator, imports all modules, defines:
  - Global packages (`home.packages`)
  - Shell aliases (`home.shellAliases`)
  - Session variables (`home.sessionVariables`)
  - PATH extensions (`home.sessionPath`)
  - Platform-specific settings
- `overlays.nix` - Custom package definitions and patches
- `packages/` - Custom Nix package derivations (jj-spr, nv-tmikus)

## Configuration Patterns

### Module Structure
```nix
{ lib, pkgs, ... }:
{
  programs.<tool>.enable = true;
  programs.<tool>.<settings> = { ... };
}
```

### Platform-Specific Configuration
```nix
# Conditional based on platform
lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin { ... }
lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux { ... }
```

### Config File Placement
```nix
# For dotfiles in home directory
home.file.".config-file" = { source = ./file; };

# For XDG-compliant configs
xdg.configFile."app/config" = { source = ./config; };

# For entire directories
xdg.configFile."app" = { source = ./app-dir; recursive = true; };
```

### External Theme Fetching
```nix
pkgs.fetchFromGitHub {
  owner = "catppuccin";
  repo = "tool";
  rev = "commit-hash";
  sha256 = "hash";
}
```

## Module Categories

- **Shell**: `zsh.nix`, `fish.nix`, `starship.nix`
- **Terminal**: `alacritty/`, `ghostty/`, `wezterm/`
- **Multiplexers**: `tmux.nix`, `zellij/`
- **Editors**: `neovim.nix`, `zed/`, `intellij/`
- **VCS**: `git.nix`, `gitui.nix`, `jujutsu.nix`
- **Dev Tools**: `mise.nix`, `fzf.nix`, `direnv.nix`, `zoxide.nix`
- **Languages**: `java.nix`

## Theme

The configuration uses Catppuccin (Mocha variant) consistently across tools including tmux, gitui, yazi, and terminal emulators.

## State Version

Home Manager state version is 23.11. Do not change without understanding migration implications.
