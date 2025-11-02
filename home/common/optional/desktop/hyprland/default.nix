{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hypr
    ./hypridle.nix
    ./hyprpaper.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
    systemd = {
      enable = false;
    };
    settings = {
      exec-once = [
        "uwsm app -- mako"
        "uwsm app -- swayosd-server"
        "uwsm app -- walker --gapplication-service &"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "wl-clip-persist --clipboard regular --all-mime-type-regex '^(?!x-kde-passwordManagerHint).+'"
      ];
    };
  };
}
