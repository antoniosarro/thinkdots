{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
{
  programs.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
  };

  # Simple UWSM configuration
  programs.uwsm = {
    enable = true;
    waylandCompositors.hyprland = {
      prettyName = "Hyprland";
      comment = "Hyprland compositor";
      binPath = "${config.programs.hyprland.package}/bin/Hyprland";
    };
  };

  environment.systemPackages = [
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    pkgs.unstable.uwsm
  ];

  assertions = [
    {
      assertion =
        config.programs.hyprland.package
        == config.home-manager.users.${config.hostSpec.primaryUsername}.wayland.windowManager.hyprland.package;
      message = "NixOS and Home-manager Hyprland package must be the same version.";
    }
  ];
}
