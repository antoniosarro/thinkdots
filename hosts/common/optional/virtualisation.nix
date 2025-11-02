{
  pkgs,
  config,
  inputs,
  ...
}:
let
  virtLib = inputs.nixvirt.lib;
in
{
  imports = [
    inputs.nixvirt.nixosModules.default
  ];

  boot.kernelModules = [ "vfio-pci" ];

  virtualisation = {
    docker = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
      storageDriver = "overlay2";
      liveRestore = true;
      daemon.settings = {
        default-address-pools = [
          {
            base = "172.17.0.0/12";
            size = 20;
          }
        ];
        ip = "127.0.0.1";
        experimental = true;
      };
    };
    oci-containers = {
      backend = "docker";
      containers = {
        "portainer" = {
          autoStart = true;
          image = "portainer/portainer-ce:lts";
          volumes = [
            "/var/run/docker.sock:/var/run/docker.sock"
            "portainer_data:/data"
          ];
          ports = [
            "8000:8000"
            "9443:9443"
          ];
        };
      };
    };
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        ovmf = {
          enable = true;
        };
      };
    };
    libvirt = {
      enable = true;
      connections = {
        "qemu:///system" = {
          networks = [
            {
              active = true;
              definition = virtLib.network.writeXML {
                uuid = "8e91d351-e902-4fce-99b6-e5ea88ac9b80";
                name = "vm-lan";
                forward = {
                  mode = "nat";
                  nat = {
                    nat = {
                      port = {
                        start = 1024;
                        end = 65535;
                      };
                    };
                    ipv6 = false;
                  };
                };
                bridge = {
                  name = "virbr0";
                  stp = true;
                  delay = 0;
                };
                ipv6 = false;
                ip = {
                  address = "192.168.1.0";
                  netmask = "255.255.255.0";
                  dhcp = {
                    range = {
                      start = "192.168.1.100";
                      end = "192.168.1.254";
                    };
                  };
                };
              };
            }
          ];
        };
      };
    };
  };

  programs.virt-manager.enable = true;

  environment.systemPackages = [
    pkgs.qemu_kvm
    pkgs.qemu
  ];

  users.users.${config.hostSpec.username} = {
    extraGroups = [ "libvirtd" ];
  };
}
