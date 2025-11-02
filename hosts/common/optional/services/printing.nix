{ pkgs, ... }:
{
  services.printing = {
    enable = true;
    drivers = [ pkgs.epson-escpr ];
  };

  systemd.services.cups-browsed = {
    enable = false;
    unitConfig.Mask = true;
  };

  hardware.printers = {
    ensurePrinters = [
      {
        name = "Epson_XP_305";
        location = "Home";
        deviceUri = "lpd://10.10.40.16:515/PASSTHRU";
        model = "epson-inkjet-printer-escpr/Epson-XP-302_303_305_306_Series-epson-escpr-en.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
  };
}
