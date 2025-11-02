{ config, ... }:
{
  services.logrotate = {
    enable = true;
    settings = {
      "/run/user/*/hypr/*/hyprland.log" = {
        size = "1000M";
        rotate = 5;
        compress = true;
        nocompress = true;
        missingok = true;
        notifempty = true;
        dateext = true;
      };
    };
  };
  assertions = [
    {
      assertion = (config.programs.hyprland.enable == true);
      message = "hyprland.log rotation expects that hyprland is enabled.";
    }
  ];

}
