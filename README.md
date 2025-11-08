# NixOS Configuration Structure

A modular NixOS configuration using flakes, designed for maintainability and flexibility across different hosts and users.

## Core Philosophy

This configuration separates concerns into distinct layers:
- **Hosts**: System-level configuration (hardware, services, users)
- **Home**: User-level configuration (applications, dotfiles, preferences)
- **Modules**: Reusable configuration components
- **Overlays**: Package customizations and additions

## Directory Structure
```
.
├── flake.nix              # Entry point: defines inputs and outputs
├── hosts/                 # System configurations
│   ├── common/            # Shared host configuration
│   │   ├── core/          # Essential system setup
│   │   ├── optional/      # Optional system features
│   │   └── users/         # User account definitions
│   └── nixos/             # Specific host configurations
│       └── laptop/        # Example: laptop host
├── home/                  # User environment configurations
│   ├── common/            # Shared user configuration
│   │   ├── core/          # Essential user setup
│   │   └── optional/      # Optional user features
│   └── antoniosarro/      # User-specific configurations
├── modules/               # Reusable configuration modules
│   ├── common/            # Cross-platform modules
│   ├── home/              # Home-manager modules
│   └── hosts/             # NixOS system modules
├── lib/                   # Custom library functions
├── overlays/              # Package modifications
├── pkgs/                  # Custom packages
└── wallpapers/            # Assets
```

## Configuration Layers

### 1. Flake (`flake.nix`)

The main entry point that:
- Defines all external dependencies (nixpkgs, home-manager, etc.)
- Declares available NixOS configurations
- Sets up overlays and custom packages
- Configures development environment

**When to edit**: Adding new dependencies, creating new hosts, or changing global settings.

### 2. Host Configuration (`hosts/`)

#### `hosts/common/core/`
Essential system configuration applied to all hosts:
- User management
- Nix settings
- Basic system tools
- Localization

**When to edit**: Changing fundamental system behavior across all machines.

#### `hosts/common/optional/`
Optional system features organized by category:
- **services/**: System services (bluetooth, printing, display manager)
- Individual features: audio, fonts, GPU drivers, virtualization, etc.

**When to edit**: Enabling/disabling system-level features like Hyprland, virtualization, or audio setup.

#### `hosts/nixos/{hostname}/`
Host-specific configuration:
- Hardware configuration
- Disk partitioning (disko)
- Host specifications (hostSpec)
- Import of common and optional modules

**When to edit**: 
- Adding a new machine: Create new directory here
- Host-specific settings: Monitor configuration, hardware quirks

### 3. Home Configuration (`home/`)

#### `home/common/core/`
Essential user environment:
- **shell/**: Terminal tools (zsh, starship, tmux, etc.)
- Terminal emulators (kitty, ghostty)
- Git configuration
- XDG directories

**When to edit**: Changing default shell setup or terminal configuration.

#### `home/common/optional/`
Optional user features organized by category:
- **browsers/**: Web browsers (Firefox, Chromium, Zen)
- **comms/**: Communication apps (Discord, Teams, Telegram)
- **desktop/**: Desktop environment (Hyprland, Waybar, Walker)
- **development/**: Development tools
- **media/**: Media applications (Spotify with Spicetify)
- **scripts/**: Custom scripts
- **tools/**: Productivity tools

**When to edit**:
- Adding new applications: Create appropriate subdirectory
- Configuring desktop environment: Edit `desktop/hyprland/`

#### `home/{username}/`
User-specific configuration:
- `laptop.nix`: Configuration for specific host
- `common/`: Shared across user's machines

**When to edit**: User-specific overrides or host-specific user settings.

### 4. Modules (`modules/`)

Reusable configuration components:

#### `modules/common/`
- `host-spec.nix`: Host metadata and specifications
- `nix.nix`: Nix daemon settings

#### `modules/home/`
- `monitors.nix`: Monitor configuration abstraction

#### `modules/hosts/`
- NixOS-specific modules
- Warning suppression utilities

**When to edit**: Creating reusable configuration patterns or abstractions.

### 5. Supporting Components

#### `lib/`
Custom helper functions:
- `relativeToRoot`: Path helper
- `scanPaths`: Automatic module discovery

**When to edit**: Adding new utility functions used across configuration.

#### `overlays/`
Package customizations:
- Stable/unstable package channels
- Package modifications
- Custom package additions

**When to edit**: Overriding package versions or adding custom packages.

## Common Workflows

### Adding a New Host

1. Create `hosts/nixos/{hostname}/default.nix`
2. Define `hostSpec` (hostname, users, etc.)
3. Import required `hosts/common/optional/` modules
4. Create hardware configuration or disko layout
5. Add to `flake.nix` outputs (automatic via `builtins.readDir`)

### Adding a New Application

**System-level** (requires root):
1. Create module in `hosts/common/optional/`
2. Import in host's `default.nix`

**User-level** (no root needed):
1. Create module in `home/common/optional/{category}/`
2. Import in `home/{username}/{hostname}.nix`

### Configuring Desktop Environment

Edit `home/common/optional/desktop/hyprland/`:
- `hypr/bind.nix`: Keybindings
- `hypr/style.nix`: Appearance
- `hypr/environment.nix`: Environment variables
- `waybar.nix`: Status bar
- `mako.nix`: Notifications

### Adding Custom Scripts

1. Create script in `home/common/optional/scripts/`
2. Use `pkgs.writeShellApplication` for packaging
3. Add to scripts `default.nix`

## Key Concepts

### hostSpec
Metadata about each host (defined in each host's `default.nix`):
- `hostName`: Machine identifier
- `username`/`primaryUsername`: User accounts
- `email`: Contact information
- Feature flags: `isMinimal`, `isProduction`, `useWayland`, etc.

**Usage**: Access via `config.hostSpec` in any module.

### Module Imports
Modules use `lib.custom.relativeToRoot` for consistent path resolution:
```nix
imports = map lib.custom.relativeToRoot [
  "hosts/common/core"
  "hosts/common/optional/audio.nix"
];
```

### Optional Features
Features are opt-in via explicit imports rather than option toggles, providing clarity about what's enabled.

```

## Quick Reference

|-----------------------|-------------------------------------------|
|  Task                 |  Location                                 |
|-----------------------|-------------------------------------------|
|  Add system service   |  `hosts/common/optional/`                 |
|  Configure Hyprland   |  `home/common/optional/desktop/hyprland/` |
|  Add user application |  `home/common/optional/{category}/`       |
|  New host             |  `hosts/nixos/{hostname}/`                |
|  Custom package       |  `pkgs/common/`                           |
|  Override package     |  `overlays/default.nix`                   |
|  Shell tools          |  `home/common/core/shell/`                |
|  System fonts         |  `hosts/common/optional/fonts.nix`        |
|  User scripts         |  `home/common/optional/scripts/`          |
|-----------------------|-------------------------------------------|

## Building and Deploying
```bash
# Build and switch configuration
nixos-rebuild switch --flake .#laptop

# Build without switching
nixos-rebuild build --flake .#laptop

# Update flake inputs
nix flake update

# Check configuration
nix flake check
```

## Development
```bash
# Enter development shell with pre-commit hooks
nix develop

# Format all Nix files
nix fmt

# Run checks
nix flake check
```