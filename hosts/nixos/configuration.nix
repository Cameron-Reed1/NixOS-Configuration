# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # User configuration
    ../../common/users/users.nix
  ];
  

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  


  # Disable checking /home partition with fsck
  # Arch has a newer version than Nix, so it throws an error, and fails to boot
  fileSystems."/home" = {
    noCheck = true;
  };



  # Bootloader Configuration

  boot.loader = {
    efi.canTouchEfiVariables = true;

    systemd-boot = {
      enable = true;
      editor = false;
      configurationLimit = 5;
      extraInstallCommands = ''
        ${pkgs.gnused}/bin/sed -i 's/^version Generation \([0-9]\+\).*$/version Generation \1/' /boot/loader/entries/nixos-generation-*
        ${pkgs.gnused}/bin/sed -i 's/^default .*$/default 00-arch.conf/' /boot/loader/loader.conf
      '';
    };
  };

  boot.kernelParams = [ "quiet" "splash" ];



  # Power Configuration

  services.tlp = {
    enable = true;
  };



  # Locale Configuration

  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };



  # Sound Configuration

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    # jack.enable = true


    wireplumber.enable = true;
  };



  # Package Configuration

  programs = {
    zsh.enable = true;
    vim.defaultEditor = true;
  };

  environment.systemPackages = (with pkgs; [
    vim
    neovim
    git
    wget
    kitty
    ranger
    lf
    firefox

    greetd.tuigreet
  ]);

  environment.shells = with pkgs; [ bash zsh ];

  xdg.portal.wlr.enable = true;
  nixpkgs.config.allowUnfree = true;



  # Networking Configuration

  networking = {
    hostName = "nixos";

    networkmanager = {
      enable = true;
    };

    firewall = {
      allowedTCPPortRanges = [
        # GSConnect
        #{ from = 1714; to = 1764; }
      ];
      allowedUDPPortRanges = [
        # GSConnect
        #{ from = 1714; to = 1764; }
      ];
    };
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
  };



  # Time Configuration

  time.timeZone = "America/Denver";



  # CUPS (Printing) Configuration

  services.printing = {
    enable = false;
  };



  # X11 Configuration


  services.xserver = {
    enable = false;

    layout = "us";
    libinput = {
      touchpad = {
        tapping = true;
      };
    };

    excludePackages = [ pkgs.xterm ];
  };



  # Login Manager Configuration

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };



  # Desktop Environment Configuration

  programs = {
    sway = {
      enable = true;

      extraPackages = with pkgs; [
        swaylock
        swayidle
        dmenu
        wmenu
        i3status
        brightnessctl
        wob
      ];
    };
  };



  # User Configuration

  user.cameron.enable = true;



  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  # system.autoUpgrade.enable = true;
  # system.autoUpgrade.allowReboot = false;
}
