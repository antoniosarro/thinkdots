{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = {
    # Disable other getty services on tty1
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;

    services.greetd = {
      enable = true;
      restart = true;
      vt = 1;

      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --asterisks --remember --time --time-format '%I:%M %p | %a • %h | %F' --cmd 'uwsm start hyprland.desktop'";
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
      # Ensure greetd starts after system is ready
      unitConfig = {
        After = [
          "systemd-user-sessions.service"
          "plymouth-quit-wait.service"
          "getty@tty1.service"
        ];
      };
    };
  };
}
