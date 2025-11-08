{
  pkgs,
  config,
  lib,
  ...
}:
{
  # Create desktop entry for UWSM
  xdg.dataFile."wayland-sessions/hyprland-uwsm.desktop".text = ''
    [Desktop Entry]
    Name=Hyprland (UWSM)
    Comment=Hyprland managed by UWSM
    Exec=${pkgs.unstable.uwsm}/bin/uwsm start hyprland-uwsm.desktop
    Type=Application
  '';

  # Create UWSM app entry
  xdg.configFile."uwsm/applications.d/hyprland-uwsm.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Hyprland
    Comment=Hyprland Wayland compositor
    Exec=${config.wayland.windowManager.hyprland.package}/bin/Hyprland
    DesktopNames=Hyprland
  '';

  # UWSM environment configuration
  xdg.configFile."uwsm/env".text = ''
    # Core Wayland environment
    export XDG_SESSION_TYPE=wayland
    export XDG_SESSION_DESKTOP=Hyprland
    export XDG_CURRENT_DESKTOP=Hyprland

    # Enable Wayland for various toolkits
    export NIXOS_OZONE_WL=1
    export MOZ_ENABLE_WAYLAND=1
    export QT_QPA_PLATFORM=wayland
    export GDK_BACKEND=wayland
    export SDL_VIDEODRIVER=wayland
    export CLUTTER_BACKEND=wayland

    # Hyprland specific
    export HYPRCURSOR_THEME=rose-pine-hyprcursor
    export HYPRCURSOR_SIZE=24
    export XCURSOR_SIZE=24
  '';

  # UWSM-specific Hyprland environment
  xdg.configFile."uwsm/env-hyprland".text = ''
    # Additional Hyprland-specific environment variables
    export WLR_NO_HARDWARE_CURSORS=1
  '';

  home.packages = [ pkgs.unstable.uwsm ];
}
