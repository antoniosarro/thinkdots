{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = {
    services.greetd = {
      enable = true;
      restart = true;

      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --asterisks --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
          # command = "${pkgs.greetd.tuigreet}/bin/tuigreet --asterisks --time --time-format '%I:%M %p | %a • %h | %F' --cmd uwsm start -- hyprland-uwsm.desktop";
          user = "antoniosarro";
        };
      };
    };
  };
}
