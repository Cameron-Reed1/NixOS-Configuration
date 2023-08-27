{ ... }:

{
  boot.loader = {
    efi.canTouchEfiVariables = true;

    systemd-boot = {
      enable = true;
      editor = false;
      configurationLimit = 5;
      extraInstallCommands = ''
        sed -i 's/^version Generation \([0-9]\+\).*$/version Generation \1/' /boot/loader/entries/nixos-generation-*
        sed -i 's/^default .*$/default 00-arch.conf/' /boot/loader/loader.conf
      '';
    };
  };
}
