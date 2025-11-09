{ pkgs, config, ... }:
{
  # Simple UWSM environment setup
  xdg.configFile."uwsm/env".text = ''
    # Core Wayland environment
    export XDG_SESSION_TYPE=wayland
    export XDG_SESSION_DESKTOP=Hyprland
    export XDG_CURRENT_DESKTOP=Hyprland
  '';

  home.packages = [ pkgs.unstable.uwsm ];
}
