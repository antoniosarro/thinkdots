# ===================================================================
#
# Main Laptop
# NixOS Running on Intel I7
#
# ===================================================================

{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = lib.flatten [
    # ============================
    # Hardware
    # ============================
    ./hardware-configuration.nix
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-laptop
    inputs.hardware.nixosModules.common-pc-laptop-ssd

    # ============================
    # Disk Layout
    # ============================
    inputs.disko.nixosModules.disko
    (lib.custom.relativeToRoot "hosts/common/disks/laptop.nix")

    (map lib.custom.relativeToRoot [
      # Required Configs
      "hosts/common/core"

      # Services
      "hosts/common/optional/services/bluetooth.nix"
      "hosts/common/optional/services/greetd.nix"
      "hosts/common/optional/services/logrotate.nix"
      "hosts/common/optional/services/printing.nix"

      # Optional Configs
      "hosts/common/optional/audio.nix"
      "hosts/common/optional/flatpak.nix"
      "hosts/common/optional/fonts.nix"
      "hosts/common/optional/gpu.nix"
      "hosts/common/optional/graphene.nix"
      "hosts/common/optional/hyprland.nix"
      "hosts/common/optional/mpv.nix"
      "hosts/common/optional/obsidian.nix"
      "hosts/common/optional/protonvpn.nix"
      "hosts/common/optional/thunar.nix"
      "hosts/common/optional/virtualisation.nix"
      "hosts/common/optional/wifi.nix"
    ])
  ];

  # ============================
  # Host Specification
  # ============================
  hostSpec = {
    hostName = "laptop";
    username = "antoniosarro";
    users = [ "antoniosarro" ];
  };

  networking = {
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = lib.mkDefault 10;
    };
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  boot.initrd = {
    systemd.enable = true;
  };

  boot.kernelParams = [
    # Better power management for Tiger Lake
    "i915.enable_psr=1"
    "i915.enable_fbc=1"
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  system.stateVersion = "25.05";
}
