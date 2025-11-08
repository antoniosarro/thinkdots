{ config, ... }:
{
  home.file.".config/uwsm/env".text = ''
    # Environment variables for UWSM-managed Hyprland session
    export NIXOS_OZONE_WL=1
    export MOZ_ENABLE_WAYLAND=1
    export QT_QPA_PLATFORM=wayland
    export GDK_BACKEND=wayland
    export XDG_SESSION_TYPE=wayland
    export XDG_CURRENT_DESKTOP=Hyprland
    export XDG_SESSION_DESKTOP=Hyprland
  '';

  home.file.".config/uwsm/env-hyprland".text = ''
    # Hyprland-specific environment
    export HYPRCURSOR_THEME=rose-pine-hyprcursor
    export HYPRCURSOR_SIZE=24
  '';
}
