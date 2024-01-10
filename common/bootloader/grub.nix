{ config, lib, ... }:

with lib; let
  cfg = config.grub;
in {
  options.grub = {
    device = mkOption {
      default = "";
      example = "/dev/disk/by-id/wwn-0x500001234567890a";
      type = types.str;
      description = lib.mdDoc ''
        The device on which the GRUB boot loader will be installed.
        Setting this option also sets GRUB to use legacy boot.
        For EFI, do not set this option.
      '';
    };
  };

  config = mkMerge [

    {
      boot.loader.grub = {
        enable = true;

        configurationLimit = 25;
        default = "saved";
        useOSProber = true;
        memtest86.enable = true;
      }
    }

    (mkIf (cfg.device == "") {
      boot.loader = {
        efi.canTouchEfiVariables = true;
        grub = {
          efiSupport = true;
          device = "nodev";
        };
      };
    })

    (mkIf (cfg.device != "") { boot.loader.grub.device = cfg.device; })

  ];
}
