{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Disable getty on tty1
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  services.greetd = {
    enable = true;
    restart = true;
    vt = 1;

    settings = {
      default_session = {
        # Simple UWSM start command
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --asterisks --remember --time --cmd 'uwsm start -F hyprland'";
        user = "greeter";
      };
    };
  };

  systemd.services.greetd = {
    serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
    unitConfig = {
      After = [
        "systemd-user-sessions.service"
        "plymouth-quit-wait.service"
      ];
      Conflicts = [ "getty@tty1.service" ];
    };
  };
}
