# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, common_dir, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      (common_dir + /options.nix)

      (common_dir + /bootloader/grub.nix)
      (common_dir + /users/users.nix)

      # ./minecraft.nix
      # ./frp.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  
  # Use the GRUB 2 boot loader with legacy boot
  grub.device = "/dev/sda";


  # USB WiFi driver kernel module
  boot.extraModulePackages = [ config.boot.kernelPackages.rtl88xxau-aircrack ];
  boot.kernelModules = [ "88XXau" "sg" ];


  networking.hostName = "nixserver";
  networking.networkmanager.enable = true;

  services.tailscale = {
    enable = true;
    openFirewall = true;
    extraUpFlags = [
      "--login-server=https://scale.cam123.dev:443"
    ];
  };


  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  user.cameron.enable = true;

  programs = {
    zsh.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    git
    curl
    wget
    ranger
    lf
    tmux
    gcc

    # Temp
    makemkv
  ];

  # Also temporary
  nixpkgs.config.allowUnfree = true;
  
  environment.shells = with pkgs; [ bash zsh ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # Enable Jellyfin
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  security.acme.acceptTerms = true;
  security.acme.certs."owl.cam123.dev" = {
    dnsResolver = "1.1.1.1:53";
    dnsProvider = "cloudflare";
    email = "cameron@cam123.dev";
    environmentFile = "/var/acme/secrets/.env";
    extraDomainNames = [ "jelly.cam123.dev" ];
  };
  

  services.nginx = {
    enable = true;
    virtualHosts = {
      "jelly.cam123.dev" = {
        forceSSL = true;
        useACMEHost = "owl.cam123.dev";
        locations."/" = {
          proxyPass = "http://127.0.0.1:8096";
          recommendedProxySettings = true;
        };
      };

      "owl.cam123.dev" = {
        forceSSL = true;
        enableACME = true;
        acmeRoot = null;
        locations."/" = {
          proxyPass = "http://127.0.0.1:8080";
          recommendedProxySettings = true;
        };
      };
    };
  };

  virtualisation.oci-containers = {
    backend = "docker";

    containers.kitchenowl = {
      image = "tombursch/kitchenowl:latest";
      environmentFiles = [ /home/cameron/kitchenowl/.env ];
      volumes = [ "/home/cameron/kitchenowl/data:/data" ];
      ports = [ "8080:8080" ];
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}

