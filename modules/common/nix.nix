{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;
  };

  nix = {
    package = lib.mkForce pkgs.unstable.nixVersions.latest;
    optimise = {
      automatic = true;
      dates = [ "22:00" ];
    };
    settings = {
      connect-timeout = 5;
      log-lines = 25;
      min-free = 128000000;
      max-free = 1000000000;
      experimental-features = lib.mkDefault "nix-command flakes";
      warn-dirty = false;
      allow-import-from-derivation = true;
      trusted-users = [ "@wheel" ];
      builders-use-substitutes = true;
      fallback = true;
      substituters = [
        "https://cache.nixos.org" # Official global cache
        "https://nix-community.cachix.org" # Community packages
      ];
    };
  }
  // (lib.optionalAttrs pkgs.stdenv.isLinux {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
  });
}
