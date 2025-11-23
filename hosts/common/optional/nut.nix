{
  power.ups = {
    enable = true;
    mode = "standalone"; # use "netserver" if you want network access

    ups."nutdev-usb1" = {
      driver = "nutdrv_qx";
      port = "auto";
      # Add the subdriver and protocol options
      directives = [
        "subdriver = cypress"
        "protocol = megatec"
      ];
      description = "My UPS";
    };

    # This ensures upsd (the server) runs
    upsd = {
      enable = true;
      listen = [
        {
          address = "127.0.0.1";
          port = 3493;
        }
      ];
    };

    # Configure a monitoring user
    users = {
      upsmon = {
        password = "somepass";
        upsmon = "master";
      };
    };
  };

  # Optional: enable upsmon for monitoring
  services.upsmon = {
    enable = true;
    monitor."nutdev-usb1" = {
      system = "nutdev-usb1@localhost";
      user = "upsmon";
      password = "somepass";
      type = "master";
    };
  };
}
