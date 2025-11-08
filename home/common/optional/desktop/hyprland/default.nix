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
    ./mako.nix
    ./uwsm-hyprland.nix
    ./waybar.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
    settings = {
      exec-once = [
        "swayosd-server"
        "walker --gapplication-service &"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "wl-clip-persist --clipboard regular --all-mime-type-regex '^(?!x-kde-passwordManagerHint).+'"
      ];
    };
  };

  systemd.user.services = {
    swayosd = {
      Unit = {
        Description = "SwayOSD server";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.swayosd}/bin/swayosd-server";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    polkit-gnome = {
      Unit = {
        Description = "Polkit GNOME Authentication Agent";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    wl-clip-persist = {
      Unit = {
        Description = "Clipboard persistence";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard regular --all-mime-type-regex '^(?!x-kde-passwordManagerHint).+'";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
