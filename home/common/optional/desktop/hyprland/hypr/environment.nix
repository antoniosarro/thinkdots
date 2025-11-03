# home/common/optional/desktop/hyprland/hypr/environment.nix
{
  wayland.windowManager.hyprland.settings = {
    env = [
      # Cursor size
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"

      # XDG Specifications
      "XDG_SESSION_TYPE,wayland"

      # Intel Iris Xe specific
      "LIBVA_DRIVER_NAME,iHD"  # Critical for Tiger Lake
      "MESA_LOADER_DRIVER_OVERRIDE,iris"  # Use iris driver for Gen 11+
      "VDPAU_DRIVER,va_gl"

      # Qt Variables
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"

      # GDK Variables
      "GDK_BACKEND,wayland,x11,*"
      "GDK_SCALE,1.25"
      "GDK_DPI_SCALE,0.8"

      # Toolkit Backend Variables
      "QT_QPA_PLATFORM,wayland;xcb"
      "QT_STYLE_OVERRIDE,kvantum"

      # Hyprcursor
      "HYPRCURSOR_THEME,rose-pine-hyprcursor"

      # Force all apps to use Wayland
      "SDL_VIDEODRIVER,wayland"
      "OZONE_PLATFORM,wayland"

      # Allow better support for screen sharing
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_DESKTOP,Hyprland"

      # Electron stuff
      "NIXOS_OZONE_WL,1"
      "ELECTRON_OZONE_PLATFORM_HINT,wayland"

      # Firefox stuff
      "MOZ_ENABLE_WAYLAND,1"
      "MOZ_WEBRENDER,1"

      # Use XCompose file
      "XCOMPOSEFILE,~/.XCompose"
    ];

    xwayland = {
      force_zero_scaling = false;
    };

    ecosystem = {
      no_update_news = true;
    };
  };
}