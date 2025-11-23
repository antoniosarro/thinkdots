{
  power.ups = {
    enable = true;
    mode = "standalone";

    ups."nutdev-usb1" = {
      driver = "nutdrv_qx";
      port = "auto";
      directives = [
        "subdriver = cypress"
        "protocol = megatec"
      ];
      description = "My UPS";
    };

    upsd = {
      enable = true;
      listen = [
        {
          address = "127.0.0.1";
          port = 3493;
        }
      ];
    };

    users = {
      upsmon = {
        password = "somepass"; # or use passwordFile
        upsmon = "master";
      };
    };

    # Add upsmon configuration here
    upsmon = {
      monitor."nutdev-usb1" = {
        user = "upsmon";
        passwordFile = "/etc/nut/upsmon-password"; # or just use: password = "somepass";
        type = "master";
        powerValue = 1; # This fixes the error
      };
    };
  };
}
