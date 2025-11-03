{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
{
  # environment.loginShellInit = ''
  #   if uwsm check may-start && uwsm select; then
  #     exec uwsm start default
  #   fi
  # '';

  programs.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
    package = pkgs.unstable.hyprland;
  };

  environment.systemPackages = [
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
  ];

  assertions = [
    {
      assertion =
        config.programs.hyprland.package
        == config.home-manager.users.${config.hostSpec.primaryUsername}.wayland.windowManager.hyprland.package;
      message = "NixOS and Home-manager Hyprland package must be the same version.";
    }
    {
      assertion = (
        lib.strings.compareVersions config.hardware.graphics.package.version "25.2.0" == -1
        || lib.strings.compareVersions config.programs.hyprland.package.version "0.51.0" != -1
      );
      message = "Mesa 25.2.x has breaking ABI change, Hyprland 0.51.0 or newer is required.";
    }
  ];
}
