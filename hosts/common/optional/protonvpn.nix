{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.protonvpn-cli
    pkgs.protonvpn-gui
  ];

  networking.firewall.checkReversePath = false;
}
