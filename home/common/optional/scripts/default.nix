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
  nixdots-cmd-present = pkgs.writeShellApplication {
    name = "nixdots-cmd-present";
    runtimeInputs = [
      pkgs.jq
    ];
    text = builtins.readFile ./nixdots-cmd-present;
  };
  nixdots-launch-browser = pkgs.writeShellApplication {
    name = "nixdots-launch-browser";
    runtimeInputs = [
      pkgs.jq
    ];
    text = builtins.readFile ./nixdots-launch-browser;
  };
  nixdots-launch-editor = pkgs.writeShellApplication {
    name = "nixdots-launch-editor";
    runtimeInputs = [
      pkgs.jq
    ];
    text = builtins.readFile ./nixdots-launch-editor;
  };
  nixdots-launch-or-focus = pkgs.writeShellApplication {
    name = "nixdots-launch-or-focus";
    runtimeInputs = [
      pkgs.jq
    ];
    text = builtins.readFile ./nixdots-launch-or-focus;
  };
in
{
  home.packages = [
    (pkgs.symlinkJoin {
      name = "nixdots-scripts";
      paths = [
        nixdots-battery-remaining
        nixdots-cmd-audio-switch
        nixdots-cmd-present
        nixdots-launch-browser
        nixdots-launch-editor
        nixdots-launch-or-focus
      ];
    })
  ];
}
