{
  inputs,
  outputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  platform = "nixos";
  platformModules = "${platform}Modules";
in
{
  imports = lib.flatten [
    inputs.home-manager.${platformModules}.home-manager
    inputs.nix-index-database.${platformModules}.nix-index
    { programs.nix-index-database.comma.enable = true; }

    (map lib.custom.relativeToRoot [
      "modules/common"
      "modules/hosts/common"
      "modules/hosts/${platform}"

      "hosts/common/core/${platform}.nix"

      "hosts/common/users/"
    ])
  ];

  hostSpec = {
    primaryUsername = "antoniosarro";
    username = "antoniosarro";
    handle = "antoniosarro";
    email = {
      github = "tech@antoniosarro.dev";
    };
  };

  networking.hostName = config.hostSpec.hostName;

  # System-wide packages, in case we log in as root
  environment.systemPackages = [ pkgs.openssh ];

  # Force home-manager to use global packages
  home-manager.useGlobalPkgs = true;
  # If there is a conflict file that is backed up, use this extension
  home-manager.backupFileExtension = "bk";

  # ===============================
  # Overlays
  # ===============================
  nixpkgs = {
    overlays = [
      outputs.overlays.default
    ];
    config = {
      allowUnfree = true;
    };
  };

  # ===============================
  # Basic Shell Enablement
  # ===============================
  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };
}
