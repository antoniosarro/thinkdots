{ pkgs, ... }:
let
  nixdots-battery-remaining = pkgs.writeShellApplication {
    name = "nixdots-battery-remaining";
    runtimeInputs = [
    ];
    text = builtins.readFile ./nixdots-battery-remaining;
  };
  nixdots-cmd-audio-switch = pkgs.writeShellApplication {
    name = "nixdots-cmd-audio-switch";
    runtimeInputs = [
      pkgs.jq
    ];
    text = builtins.readFile ./nixdots-cmd-audio-switch;
  };
  nixdots-launch-browser = pkgs.writeShellApplication {
    name = "nixdots-launch-browser";
    runtimeInputs = [
      pkgs.jq
    ];
    text = builtins.readFile ./nixdots-launch-browser;
  };
in
{
  home.packages = [
    (pkgs.symlinkJoin {
      name = "nixdots-scripts";
      paths = [
        nixdots-battery-remaining
        nixdots-cmd-audio-switch
        nixdots-launch-browser
      ];
    })
  ];
}
