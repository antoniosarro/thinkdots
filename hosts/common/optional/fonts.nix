{
  pkgs,
  ...
}:
{
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = (
      builtins.attrValues {
        inherit (pkgs)
          eb-garamond
          overpass
          noto-fonts
          noto-fonts-emoji
          ;

        inherit (pkgs.unstable.nerd-fonts)
          iosevka
          symbols-only
          ;
      }
    );
    fontconfig.defaultFonts = {
      serif = [
        "Noto Color Emoji"
        "EB Garamond"
        "Nerd Fonts Symbols Only"
      ];
      sansSerif = [
        "Noto Color Emoji"
        "Nerd Fonts Symbols Only"
        "Overpass"
      ];
      monospace = [
        "Noto Color Emoji"
        "Iosevka Nerd Font Mono"
        "Nerd Fonts Symbols Only"
      ];
      emoji = [
        "Noto Color Emoji"
        "Nerd Fonts Symbols Only"
      ];
    };
  };
}
