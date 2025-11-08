{ pkgs, ... }:
let
  nixdots-battery-remaining = pkgs.writeShellApplication {
    name = "nixdots-battery-remaining";
    runtimeInputs = [
      pkgs.jq
    ];
    text = builtins.readFile ./nixdots-battery-remaining;
  };
in
{
  home.packages = [
    (pkgs.symlinkJoin {
      name = "nixdots-scripts";
      paths = [
        nixdots-battery-remaining
      ];
    })
  ];
}
